import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/api_services/auth_apis.dart';

class AuthController extends GetxController{
  late final BuildContext context;
  AuthController(this.context);
  RxBool isLoading=false.obs;
  //login
  Future<void> login(String email,password)async{
    isLoading.value=true;
    try{
      await AuthApis(context).loginApi( email, password);
    }catch (e){
      log("Error occurred:$e");
    }finally{
      isLoading.value=false;
    }
  }

// signUp
  Future<void> signUp(String userName,userEmail,userPassword)async{
    isLoading.value=true;
    try{
      await AuthApis(context).signUpApi(userName, userEmail, userPassword);
    }catch (e){
      log("Error occurred:$e");
    }finally{
      isLoading.value=false;
    }
  }


  // verifyEmail
  Future<void> verifyEmail(String userEmail)async{
    isLoading.value=true;
    try{
      await AuthApis(context).emailVerifyApi(userEmail);
    }catch (e){
      log("Error occurred:$e");
    }finally{
      isLoading.value=false;
    }
  }

}