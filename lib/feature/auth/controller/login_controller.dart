import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/services_class/local_service/local_data.dart';
import 'package:prettyrini/route/route.dart';
import '../../../core/global_widegts/app_snackbar.dart';
import '../../../core/network_caller/endpoints.dart';
import '../../../core/network_caller/network_config.dart';


class LoginController extends GetxController {
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isLoginLoading = false.obs;
  var isLoginLoadingError = "".obs;
  final NetworkConfig _networkConfig = NetworkConfig();



  Future<bool> loginUser()async{
    if (emailTEController.text.isEmpty ||
        passwordTEController.text.isEmpty) {
      AppSnackbar.show(message: 'Please fill all fields', isSuccess: false);
      return false;
    }
    try{
      isLoginLoading.value = true;
      String email = emailTEController.text;
      String password = passwordTEController.text;
      final Map<String, dynamic> requestBody = {
        "email": email,
        "password": password,
      };
      log(requestBody.toString());
      final response = await _networkConfig.ApiRequestHandler(
          RequestMethod.POST,
          Urls.login,
          json.encode(requestBody),
        is_auth: false,
      );
      if (response['success'] == false) {
        AppSnackbar.show(message: response['message'], isSuccess: false);
      }

      if (response != null && response['success'] == true) {
        var  localService = await LocalService();
      await   localService.setToken( response["data"]["token"]);
      await   localService.setRole( response["data"]["role"]);
      var token = await localService.getToken();
        String role = await localService.getRole();
      if(role == RoleType.PROFESSIONAL.name){
         Get.offAllNamed(AppRoute.adminBusinessScreen);
      }else if(role == RoleType.USER.name){
         Get.offNamed(AppRoute.profileScreen);
      }

        AppSnackbar.show(message: "Login Successful", isSuccess: true);
        return true;
      } else {
        AppSnackbar.show(message: "Failed To Login1", isSuccess: false);
        return false;
      }
    }catch(e){
      isLoginLoadingError.value = e.toString();
      AppSnackbar.show(message: "Failed To Login $e", isSuccess: false);
      return false;
    }finally{
      isLoginLoading.value= false;
    }
  }
  @override
  void dispose() {
    super.dispose();
    emailTEController.dispose();
    passwordTEController.dispose();
  }

}

enum RoleType {ADMIN, PROFESSIONAL, USER}
