import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network_caller/endpoints.dart';
import '../../auth/screen/login_screen.dart';

class ChangePaswordController extends GetxController {
  TextEditingController oldpaswordController = TextEditingController();
  TextEditingController newpaswordController = TextEditingController();
  TextEditingController confirmpaswordController = TextEditingController();
  final NetworkConfig _networkConfig = NetworkConfig();
  final isUpdatePasswordLoading = false.obs;

  void changePassword() async {
    if (newpaswordController.text != confirmpaswordController.text) {
      AppSnackbar.show(message: "Password not match", isSuccess: false);
    } else {
      if (newpaswordController.text.length <= 7 ||
          oldpaswordController.text.length <= 7) {
        AppSnackbar.show(
            message: "Password must be at least 8 characters long.",
            isSuccess: false);
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString("token") ?? "";
        if (token.isEmpty) {
          Get.offAll(() => LoginScreen());
        } else if (oldpaswordController.text == newpaswordController.text) {
          AppSnackbar.show(
              message: "New password can't be same as old password",
              isSuccess: false);
        } else {
          try {
            isUpdatePasswordLoading.value = true;
            String oldPassword = oldpaswordController.text.trim();
            String newPassword = newpaswordController.text.trim();
            final Map<String, dynamic> requestBody = {
              "oldPassword": oldPassword,
              "newPassword": newPassword,
            };
            final response = await _networkConfig.ApiRequestHandler(
              RequestMethod.PUT,
              Urls.changePassword,
              json.encode(requestBody),
              is_auth: true,
            );

            final response2 = await _networkConfig.ApiRequestHandler(
              RequestMethod.GET,
              Urls.getUserProfile,
             {},
              is_auth: true,
            );


            log(response.toString());
            if (response != null && response['success'] == true) {
              AppSnackbar.show(
                  message: "Password Updated Successful", isSuccess: true);
            } else {
              AppSnackbar.show(
                  message: response['message'].toString(), isSuccess: false);
            }
          } catch (e) {
            AppSnackbar.show(
                message: "Failed To Update Password $e", isSuccess: false);
          } finally {
            isUpdatePasswordLoading.value = false;
          }
        }
      }
    }
  }
}
