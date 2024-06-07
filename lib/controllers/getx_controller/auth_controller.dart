import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/api_services/auth_apis.dart';
import 'package:my_journel/view/screens/auth_Screens/otp_screen.dart';

import '../utils/local_storage_variables.dart';

class AuthController extends GetxController {
  late final BuildContext context;
  AuthController(this.context);
  RxBool isLoading = false.obs;

  //login
  Future<void> login(String email, password) async {
    isLoading.value = true;
    try {
      await AuthApis(context).loginApi(email, password);
    } catch (e) {
      log("Error occurred:$e");
    } finally {
      isLoading.value = false;
    }
  }

// signUp
  Future<void> signUp(
      String userName, String userEmail, String userPassword) async {
    isLoading.value = true;
    try {
      await AuthApis(context).signUpApi(userName, userEmail, userPassword);
      if (userId.isNotEmpty) {
        Get.to(
          () => OtpScreen(
            email: userEmail,
            type: 'email',
          ),
        );
      }
    } catch (e) {
      log("Error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // verifyEmail
  Future<void> verifyEmail(String userEmail) async {
    isLoading.value = true;
    try {
      await AuthApis(context).emailVerifyApi(userEmail);
    } catch (e) {
      log("Error occurred:$e");
    } finally {
      isLoading.value = false;
    }
  }

  // verifyEmailOtp
  Future<void> verifyEmailOtp(String userOtp, String type) async {
    isLoading.value = true;
    try {
      await AuthApis(context).emailVerifyOtpApi(userOtp, userId);
    } catch (e) {
      isLoading.value = false;
      log("Error occurred:$e");
    } finally {
      isLoading.value = false;
    }
  }

  // forgot password
  Future<void> forgotPassword(String userEmail) async {
    isLoading.value = true;
    try {
      await AuthApis(context).forgotPasswordApi(userEmail);
    } catch (e) {
      isLoading.value = false;
      log("Error occurred:$e");
    } finally {
      isLoading.value = false;
    }
  }
}
