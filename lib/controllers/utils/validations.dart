import 'package:get/get.dart';


RegExp isValidEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

RegExp isValidPassword = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');




class Validations{


  //sign up handle error
static String handleSignUpError({
  firstNameController,
  lastNameController,
  emailController,
  passwordController,
  confirmPasswordController
}){ if (firstNameController.text.isEmpty) {
  return "firstName not be empty.".tr;
} else if (lastNameController.text.isEmpty) {
  return "lastName not be empty.".tr;
} else if (emailController.text.isEmpty) {
  return "Email not be empty.".tr;
} else if (passwordController.text.isEmpty) {
  return "Phone number is not be empty".tr;
}else if (confirmPasswordController.text.isEmpty) {
  return "Phone number is not match".tr;
} else if (!isValidEmail.hasMatch(emailController.text)) {
  return "Please check your email.".tr;
} else if (passwordController.text.length < 8) {
  return "Password must be at least 8 characters in length.".tr;
}else if (confirmPasswordController.text.length < 8) {
  return "password is not be less then 8".tr;
} else if (passwordController.text != confirmPasswordController.text) {
  return "password do not match please try again".tr;
} else {
  return '';
}
}

//login validation
static String loginHandleError({
  emailController,
  passwordController,
}){
  if(emailController.text.isEmpty){
    return "Email not be Empty".tr;
  }else if(passwordController.text.isEmpty){
    return "Password not be empty".tr;
  }else if(!isValidEmail.hasMatch(emailController.text)){
    return "Please check your email".tr;
  }else if(passwordController.text.length<8){
    return "Password must be at least 8 characters in length.".tr;
  }else{
    return "";
  }
}
}