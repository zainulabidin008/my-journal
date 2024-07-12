import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:my_journel/controllers/api_services/auth_apis.dart';
import 'package:my_journel/view/screens/auth_Screens/otp_screen.dart';

import '../../custom_widgets/ui_components.dart';
import '../../view/bottombar.dart';
import '../../view/screens/auth_Screens/createNew_Password.dart';
import '../utils/local_storage_variables.dart';

class AuthController extends GetxController {
  late final BuildContext context;
  AuthController(this.context);
  RxBool isLoading = false.obs;
  RxBool resendIsLoading = false.obs;
  RxString otp = "".obs;

  //login
  Future<void> login(String? email, String? password) async {
    isLoading.value = true;
    try {
      if (email == null || password == null) {
        customScaffoldMessenger(context, 'Email and password cannot be null');
        return;
      }

      final bool isLoginSuccessful =
          await AuthApis(context).loginApi(email, password);
      if (isLoginSuccessful) {}
    } catch (e) {
      log("Error occurred: $e");
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
    } catch (e) {
      log("Error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // verifyEmail
  Future<void> verifyEmail(String userEmail) async {
    resendIsLoading.value = true;
    try {
      await AuthApis(context).emailVerifyApi(userEmail);
    } catch (e) {
      log("Error occurred:$e");
    } finally {
      resendIsLoading.value = false;
    }
  }

  // verifyEmailOtp
  Future<void> verifyEmailOtp(
      String? userOtp, String type, String? email, String? password) async {
    isLoading.value = true;
    try {
      if (userOtp == null || userOtp.isEmpty) {
        customScaffoldMessenger(context, 'OTP cannot be empty');
        return;
      }

      final bool isOtpVerified =
          await AuthApis(context).emailVerifyOtpApi(userOtp, type);
      if (isOtpVerified) {
        // If OTP verification is successful, call the login method only if email and password are provided
        if (email != null && password != null) {
          await login(email, password);
        } else {
          customScaffoldMessenger(
              context, 'Email and password cannot be null for login');
        }
      }
    } catch (e) {
      log("Error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // forgot password
  Future<void> forgotPassword(String userEmail) async {
    resendIsLoading.value = true;
    try {
      await AuthApis(context).forgotPasswordApi(userEmail);
    } catch (e) {
      resendIsLoading.value = false;
      log("Error occurred:$e");
    } finally {
      resendIsLoading.value = false;
    }
  }

  Future<void> verifyPasswordOtp(String userOtp, String type) async {
    isLoading.value = true;
    try {
      await AuthApis(context).forgotPasswordVerifyOtpApi(userOtp, userId);
    } catch (e) {
      isLoading.value = false;
      log("Error occurred:$e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPasswordApi(String userOtp, String password) async {
    isLoading.value = true;
    try {
      await AuthApis(context).resetPasswordApi(userOtp, password);
      // Get.off(() => const CreateNewPassword(), arguments: {'otp': otp.value});
    } catch (e) {
      isLoading.value = false;
      log("Error occurred:$e");
    } finally {
      isLoading.value = false;
    }
  }
}
