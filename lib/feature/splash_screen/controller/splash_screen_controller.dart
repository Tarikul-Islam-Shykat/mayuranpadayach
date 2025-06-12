import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:prettyrini/route/route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/network_caller/endpoints.dart';
import '../../../core/services_class/local_service/local_data.dart';
import '../../auth/controller/login_controller.dart';
import '../../auth/screen/login_screen.dart';
import '../../auth/screen/profile_setup_screen.dart';

class SplashScreenController extends GetxController {
  var userImage = "".obs;
  var firstname = ''.obs;
  var lastName = ''.obs;
  void checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    if (kDebugMode) {
      print("token1$token");
    }
    if (token.isEmpty) {
      Get.offAll(() => LoginScreen());
    } else {
      try {
        // Make the GET request
        final response = await http.get(
          Uri.parse('${Urls.baseUrl}/auth/get-me'),
          headers: {"Authorization": token},
        );

        if (kDebugMode) {
          print(response.body);
        }
        if (response.statusCode == 201) {
          var data = jsonDecode(response.body);
          if (data['data']['isCompleted'] == true) {
            userImage.value = data['data']['profileImage'] ?? "";
            firstname.value = data['data']['firstName'];
            lastName.value = data['data']['lastName'];

            //Get.offAll(() => NavBarView());
          } else {
            Get.offAll(() => ProfileSetupScreen());
          }
        } else {
          if (kDebugMode) {
            print('Request failed with status: ${response.statusCode}');
          }
        //  Get.offAll(() => LoginScreen());
        }
      } catch (e) {
        // Handle any errors that occur during the request
        if (kDebugMode) {
          print('Error: $e');
        }
      }
    }
  }



  @override
  void onInit() async {
    super.onInit();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
   await  Future.delayed(Duration(seconds: 5),(){
     checkLoginStatus();
    });
  }

  Future<void> checkLoginStatus() async {
    final localService = await LocalService();
    final token = await localService.getToken();
    final role = await localService.getRole();

    if (token != null && token.isNotEmpty) {
      if (role == RoleType.PROFESSIONAL.name) {
        Get.offAllNamed(AppRoute.adminBusinessScreen);
      }else if(role == RoleType.ADMIN.name){
        Get.offAllNamed(AppRoute.adminBusinessScreen);
      } else if (role == RoleType.USER.name) {
        Get.offAllNamed(AppRoute.profileScreen);
      } else {
        Get.offAllNamed(AppRoute.loginScreen);
      }
    } else {
      Get.offAllNamed(AppRoute.loginScreen);
    }
  }


}
