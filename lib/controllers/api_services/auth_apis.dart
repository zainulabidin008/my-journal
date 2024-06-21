import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart';
import 'package:my_journel/controllers/api_services/base_url.dart';
import 'package:my_journel/controllers/utils/constants.dart';
import 'package:my_journel/controllers/utils/shared_preferences.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:my_journel/view/bottombar.dart';
import 'package:my_journel/view/screens/auth_Screens/createNew_Password.dart';
import 'package:my_journel/view/screens/auth_Screens/login_screen.dart';
import 'package:my_journel/view/screens/auth_Screens/otp_screen.dart';
import 'package:my_journel/view/screens/user_details/progressbar_screen.dart';

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
      customScaffoldMessenger(context, 'Successfully Login');
      Get.off(() => MyBottomBar());
    } else if (responseBody["result"] ==
        "User already registered against this email.") {
      customScaffoldMessenger(context, 'text');
    } else {
      log("login api failed");
      log(responseBody["message"]);
      customScaffoldMessenger(context, responseBody["message"]);
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
      customScaffoldMessenger(context, 'Successfully SignUp');
      emailVerifyApi(userEmail);
      MySharedPreferences.setString(userIdKey, responseBody["data"]["_id"]);
      Get.to(
        () => OtpScreen(
          email: userEmail,
          type: 'email',
        ),
      );
    } else {
      log("signUp api failed");
      log(responseBody["message"]);
      customScaffoldMessenger(context, responseBody["message"]);
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
      customScaffoldMessenger(context, 'Successfully Send Email');
    } else {
      log("Incorrect Email");
      log(responseBody["message"]);
      customScaffoldMessenger(context, responseBody["message"]);
    }
  }

  // email verify Otp api
  Future<void> emailVerifyOtpApi(String userOtp, String type) async {
    final url = Uri.parse("${BaseUrl.url}/user/auth/verifyEmailOtp");
    final headers = {"Content-Type": "application/json"};
    print("User Id$userId");
    final body = jsonEncode({
      "otp": userOtp,
      "id": MySharedPreferences.getString(userIdKey),
    });

    Response response = await post(url, headers: headers, body: body);
    final responseBody = jsonDecode(response.body);
    if (responseBody["result"] == true) {
      if (type == "forgot") {
        Get.to(() => const CreateNewPassword());
      } else if (type == "email") {
        Get.to(() => const CreateNewPassword());
      }
      log("Otp Verify Successfully");
      Get.off(() => const ProgressBarScreen());
      customScaffoldMessenger(context, 'Otp Verified Successfully');
    } else {
      log("Incorrect Otp");
      log(responseBody["message"]);
      customScaffoldMessenger(context, responseBody["message"]);
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
      Get.to(
          () => OtpScreen(
                email: userEmail,
                type: "forgot",
              ),
          arguments: {
            'userEmail': userEmail,
          });
      log("email Successfully");
      customScaffoldMessenger(context, 'Successfully Send Email');
      // Get.snackbar(
      //     backgroundColor: AppColors.blackColor,
      //     colorText: AppColors.whiteColor,
      //     "Successfully",
      //     "Successfully Send Email");
      MySharedPreferences.setString(userIdKey, responseBody["data"]["_id"]);
    } else {
      log("Incorrect Email");
      log(responseBody["message"]);
      customScaffoldMessenger(context, responseBody["message"]);
      // Get.snackbar(
      //     backgroundColor: AppColors.blackColor,
      //     colorText: AppColors.whiteColor,
      //     "Error",
      //     responseBody["message"]);
    }
  }

  Future<void> forgotPasswordVerifyOtpApi(String userOtp, String type) async {
    final url = Uri.parse("${BaseUrl.url}/user/auth/verifyPasswordOtp");
    final headers = {"Content-Type": "application/json"};
    print("User Id$userId");
    final body = jsonEncode({
      "otp": userOtp,
      "id": MySharedPreferences.getString(userIdKey),
    });

    Response response = await post(url, headers: headers, body: body);
    final responseBody = jsonDecode(response.body);
    if (responseBody["result"] == true) {
      log("Otp Verify Successfully");
      Get.off(() => const CreateNewPassword(), arguments: {'otp': userOtp});
      customScaffoldMessenger(context, 'Otp Verified Successfully');
    } else {
      log("Incorrect Otp");
      log(responseBody["message"]);
      customScaffoldMessenger(context, responseBody["message"]);
    }
  }

  Future<void> resetPasswordApi(String userOtp, String password) async {
    final url = Uri.parse(
        "${BaseUrl.url}/user/auth/newPassword/${MySharedPreferences.getString(userIdKey)}");
    final headers = {"Content-Type": "application/json"};
    print("User Id$userId");
    final body = jsonEncode({
      "newPassword": password,
      "otp": userOtp,
    });

    Response response = await post(url, headers: headers, body: body);
    final responseBody = jsonDecode(response.body);
    if (responseBody["result"] == true) {
      log("Change Password Successfully");
      customScaffoldMessenger(context, 'Change Password Successfully');
      Get.off(() => const LoginScreen());
      // Get.snackbar(
      //     backgroundColor: AppColors.blackColor,
      //     colorText: AppColors.whiteColor,
      //     "Successfully",
      //     "Otp Verified Successfully");
    } else {
      log("Incorrect Otp");
      log(responseBody["message"]);
      customScaffoldMessenger(context, responseBody["message"]);
      // Get.snackbar(
      //     backgroundColor: AppColors.blackColor,
      //     colorText: AppColors.whiteColor,
      //     "Error",
      //     responseBody["message"]);
    }
  }
}
