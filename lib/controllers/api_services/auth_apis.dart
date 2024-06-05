import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart';
import 'package:my_journel/controllers/api_services/base_url.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';

class AuthApis{
 final BuildContext context;
 AuthApis(this.context);

 // login Api
Future <void>loginApi(String email,password)async{
 final url=Uri.parse("${BaseUrl.url}/user/auth/login");
 final headers={"Content-Type":"application/json"};
 final body=jsonEncode({
 "email":email,
 "password":password,
 });
 Response response =await post(url,headers: headers,body: body);
 final responseBody=jsonDecode(response.body);
 if(responseBody["result"] == true){
  log("Login Api Successfully");
  Get.snackbar(backgroundColor: AppColors.blackColor,
      colorText: AppColors.whiteColor,
      "Successfully", "Successfully Login");
 }
 else{
  log("login api failed");
  log(responseBody["message"]);
  Get.snackbar(backgroundColor: AppColors.blackColor,
      colorText: AppColors.whiteColor,
      "Error", responseBody["message"]);
 }
}

//sign up Api
 Future <void> signUpApi(String userName,userEmail,userPassword)async{
  final url=Uri.parse("${BaseUrl.url}/user/auth/register");
  final headers={"Content-Type":"application/json"};
  final body=jsonEncode({
   "name":userName,
   "email":userEmail,
   "password":userPassword,
  });
  Response response =await post(url,headers: headers,body: body);
  final responseBody=jsonDecode(response.body);
  if(responseBody["result"] == true){
   log("signUp Api register Successfully");
   Get.snackbar(backgroundColor: AppColors.blackColor,
       colorText: AppColors.whiteColor,
       "Successfully", "Successfully SignUp");
  }
  else{
   log("signUp api failed");
   log(responseBody["message"]);
   Get.snackbar(backgroundColor: AppColors.blackColor,
       colorText: AppColors.whiteColor,
       "Error", responseBody["message"]);
  }
 }

 // email verify api
 Future <void> emailVerifyApi(String userEmail)async{
  final url=Uri.parse("${BaseUrl.url}/user/auth/register");
  final headers={"Content-Type":"application/json"};
  final body=jsonEncode({
   "email":userEmail,
  });
  Response response =await post(url,headers: headers,body: body);
  final responseBody=jsonDecode(response.body);
  if(responseBody["result"] == true){
   log("Successfully Send Email");
   Get.snackbar(backgroundColor: AppColors.blackColor,
       colorText: AppColors.whiteColor,
       "Successfully", "Successfully Send Email");
  } else{
   log("Incorrect Email");
   log(responseBody["message"]);
   Get.snackbar(backgroundColor: AppColors.blackColor,
       colorText: AppColors.whiteColor,
       "Error", responseBody["message"]);
  }
 }

}