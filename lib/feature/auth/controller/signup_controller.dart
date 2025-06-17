import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/route/route.dart';
import '../../../core/network_caller/endpoints.dart';

class SignInController extends GetxController {
  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isConPasswordVisible = false.obs;
  final isLoading = false.obs;
  final NetworkConfig _networkConfig = NetworkConfig();

  var selectedRoleItem = ''.obs;
  void selectedRole(String value) {
    selectedRoleItem.value = value;
  }

  List<String> role = ["ADMIN", "PROFESSIONAL", "USER"];


  void toggleConPasswordVisibility() {
    isConPasswordVisible.value = !isConPasswordVisible.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  var isRegisterLoading = false.obs;
  var isRegisterLoadingError = "".obs;
  Future<bool> registerUser() async {
    if (emailTEController.text.isEmpty ||
        passwordTEController.text.isEmpty ||
        nameTEController.text.isEmpty ||
        selectedRoleItem.value.isEmpty) {
      AppSnackbar.show(message: 'Please fill all fields', isSuccess: false);
      return false;
    }

    try {
      isRegisterLoading.value = true;
      String email = emailTEController.text;
      String password = passwordTEController.text;
      String name = nameTEController.text;

      final Map<String, dynamic> requestBody = {
        "fullName": name,
        "email": email,
        "password": password,
        "role": selectedRoleItem.value
      };
      log(requestBody.toString());
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        Urls.signUp,
        json.encode(requestBody),
        is_auth: false,
      );
      log("registerUser $response ${response['data']}");
      if (response['success'] == false) {
        AppSnackbar.show(message: response['message'], isSuccess: false);
      }
      if (response != null && response['success'] == true) {
        AppSnackbar.show(message: "Registration Successful", isSuccess: true);
        Get.toNamed(
          AppRoute.getOtpVerificationScreen(),
          arguments: {
            'email': email.trim(),
            "isForgot":false,
          },
        );
        return true;
      } else {
        AppSnackbar.show(message: "Failed To Registration", isSuccess: false);
        return false;
      }
    } catch (e) {
      isRegisterLoadingError.value = e.toString();
      AppSnackbar.show(message: "Failed To Registration", isSuccess: false);
      return false;
    } finally {
      isRegisterLoading.value = false;
    }
  }
}
