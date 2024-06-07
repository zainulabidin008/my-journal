import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart';
import 'package:my_journel/controllers/api_services/base_url.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/constants.dart';
import 'package:my_journel/controllers/utils/shared_preferences.dart';
import 'package:my_journel/view/screens/auth_Screens/createNew_Password.dart';
import 'package:my_journel/view/screens/auth_Screens/otp_screen.dart';

import '../utils/local_storage_variables.dart';

class AuthApis {
  final BuildContext context;
  AuthApis(this.context);

  // login Api
  Future<void> loginApi(String email, password) async {
    final url = Uri.parse("${BaseUrl.url}/user/auth/login");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": email,
      "password": password,
    });
    Response response = await post(url, headers: headers, body: body);
    final responseBody = jsonDecode(response.body);
    if (responseBody["result"] == true) {
      MySharedPreferences.setString(userIdKey, responseBody["data"]["_id"]);
      log("Login Api Successfully");
      Get.snackbar(
          backgroundColor: AppColors.blackColor,
          colorText: AppColors.whiteColor,
          "Successfully",
          "Successfully Login");
    } else {
      log("login api failed");
      log(responseBody["message"]);
      Get.snackbar(
          backgroundColor: AppColors.blackColor,
          colorText: AppColors.whiteColor,
          "Error",
          responseBody["message"]);
    }
  }

//sign up Api
  Future<void> signUpApi(String userName, userEmail, userPassword) async {
    final url = Uri.parse("${BaseUrl.url}/user/auth/register");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "name": userName,
      "email": userEmail,
      "password": userPassword,
    });
    Response response = await post(url, headers: headers, body: body);
    final responseBody = jsonDecode(response.body);
    if (responseBody["result"] == true) {
      log("signUp Api register Successfully");
      Get.snackbar(
          backgroundColor: AppColors.blackColor,
          colorText: AppColors.whiteColor,
          "Successfully",
          "Successfully SignUp");
      emailVerifyApi(userEmail);
      MySharedPreferences.setString(userIdKey, responseBody["data"]["_id"]);
    } else {
      log("signUp api failed");
      log(responseBody["message"]);
      Get.snackbar(
          backgroundColor: AppColors.blackColor,
          colorText: AppColors.whiteColor,
          "Error",
          responseBody["message"]);
    }
  }

  // email verify api
  Future<void> emailVerifyApi(String userEmail) async {
    final url = Uri.parse("${BaseUrl.url}/user/auth/emailVerify");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": userEmail,
    });
    Response response = await post(url, headers: headers, body: body);
    final responseBody = jsonDecode(response.body);
    if (responseBody["result"] == true) {
      MySharedPreferences.setString(userIdKey, responseBody["data"]["_id"]);
      Get.to(() => OtpScreen(
            email: userEmail,
            type: 'email',
          ));
      log("Successfully Send Email");
      Get.snackbar(
          backgroundColor: AppColors.blackColor,
          colorText: AppColors.whiteColor,
          "Successfully",
          "Successfully Send Email");
    } else {
      log("Incorrect Email");
      log(responseBody["message"]);
      Get.snackbar(
          backgroundColor: AppColors.blackColor,
          colorText: AppColors.whiteColor,
          "Error",
          responseBody["message"]);
    }
  }

  // email verify Otp api
  Future<void> emailVerifyOtpApi(String userOtp, String type) async {
    final url = Uri.parse("${BaseUrl.url}/user/auth/verifyEmailOtp");
    final headers = {"Content-Type": "application/json"};
    print("User Id$userId");
    final body = jsonEncode({
      "otp": userOtp,
      "id": userId,
    });

    Response response = await post(url, headers: headers, body: body);
    final responseBody = jsonDecode(response.body);
    if (responseBody["result"] == true) {
      if (type == "forgot") {
        Get.to(() => const CreateNewPassword());
      } else if (type == "email") {
        Get.to(() => const CreateNewPassword());
      }
      log("Otp Successfully");
      Get.snackbar(
          backgroundColor: AppColors.blackColor,
          colorText: AppColors.whiteColor,
          "Successfully",
          "Otp Verified Successfully");
    } else {
      log("Incorrect Otp");
      log(responseBody["message"]);
      Get.snackbar(
          backgroundColor: AppColors.blackColor,
          colorText: AppColors.whiteColor,
          "Error",
          responseBody["message"]);
    }
  }

  // forgot password api
  Future<void> forgotPasswordApi(String userEmail) async {
    final url = Uri.parse("${BaseUrl.url}/user/auth/forgetPassword");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": userEmail,
    });
    Response response = await post(url, headers: headers, body: body);
    final responseBody = jsonDecode(response.body);
    if (responseBody["result"] == true) {
      Get.to(() => OtpScreen(
            email: userEmail,
            type: "forgot",
          ));
      log("email Successfully");
      Get.snackbar(
          backgroundColor: AppColors.blackColor,
          colorText: AppColors.whiteColor,
          "Successfully",
          "Successfully Send Email");
      MySharedPreferences.setString(userIdKey, responseBody["data"]["_id"]);
    } else {
      log("Incorrect Email");
      log(responseBody["message"]);
      Get.snackbar(
          backgroundColor: AppColors.blackColor,
          colorText: AppColors.whiteColor,
          "Error",
          responseBody["message"]);
    }
  }
}
