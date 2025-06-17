import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';

import '../../../route/route.dart';

class ResetPasswordController extends GetxController{
  Rx<TextEditingController> newPassTEC = TextEditingController().obs;
  Rx<TextEditingController>  conPassTEC = TextEditingController().obs;
  RxBool isLoading = false.obs;
  final NetworkConfig _networkConfig = NetworkConfig();
  
  Future<bool> resetPassword(String email)async{
    if(newPassTEC.value.text.isEmpty || conPassTEC.value.text.isEmpty){
      AppSnackbar.show(message: "Please Enter Your Password", isSuccess: false);
      return false;
    }else if (newPassTEC.value.text != conPassTEC.value.text) {
          AppSnackbar.show(message: "Password Aren't Same", isSuccess: false);
          return false;
    }else if (newPassTEC.value.text.length < 8 || conPassTEC.value.text.length < 8) {
          AppSnackbar.show(
            message: "Password Can't Be Less then 8",
            isSuccess: false,
          );
          return false;
    }
    try{
      isLoading.value = true;
      final Map<String,dynamic>responseBody = {
        "email":email,
        "password":newPassTEC.value.text,
      };
      final response = await _networkConfig.ApiRequestHandler(
          RequestMethod.POST,
          Urls.resetPassword,
          jsonEncode(responseBody),
      );
      log("response body $responseBody");
      if(response != null && response['success']== true){
        AppSnackbar.show(message: "${response['message']}", isSuccess: true);
        Get.offNamed(AppRoute.loginScreen);
        return true;
      }else{
        AppSnackbar.show(message: "${response['message']}", isSuccess: false);
        return false;
      }
    }catch(e){
      AppSnackbar.show(message: "Response Failed$e", isSuccess: false);
      return false;
    }finally{
      isLoading.value = false;
    }

  }
}