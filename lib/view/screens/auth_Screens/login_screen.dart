import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/getx_controller/auth_controller.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/controllers/utils/validations.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:my_journel/view/screens/auth_Screens/forgetpassword.dart';
import 'package:my_journel/view/screens/auth_Screens/signup_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthController loginController;
  @override
  void initState() {
    super.initState();
    loginController = Get.put(
      AuthController(context),
    );
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Obx(() => Scaffold(
              body: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getVerticalSpace(14.h),
                        SvgPicture.asset('assets/svgs/myjournal.svg'),
                        getVerticalSpace(6.7.h),
                        Text(
                          'Log In',
                          style: AppTextStyles.boldStyle,
                        ),
                        getVerticalSpace(4.h),
                        customTextFormField(emailController, 'Email',
                            prefixIcon:
                                SvgPicture.asset('assets/svgs/emailicon.svg'),
                            isObscure: false,
                            svg: SvgPicture.asset('assets/svgs/lineicon.svg')),
                        getVerticalSpace(2.h),
                        customTextFormField(
                          passwordController,
                          'Password',
                          prefixIcon:
                              SvgPicture.asset('assets/svgs/passwordicon.svg'),
                          isObscure: true,
                          svg: SvgPicture.asset('assets/svgs/lineicon.svg'),
                        ),
                        getVerticalSpace(.8.h),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const ForgetPassword());
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot password?',
                              style: AppTextStyles.simpleSmallText.copyWith(
                                  fontSize: 12.px,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff181919)),
                            ),
                          ),
                        ),
                        getVerticalSpace(6.6.h),
                        loginController.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.blackColor,
                                ),
                              )
                            : customButton(
                                horizentalPadding: 16.h,
                                title: "Login",
                                onTap: () {
                                  String error = Validations.loginHandleError(
                                      emailController: emailController,
                                      passwordController: passwordController);
                                  if (error.isNotEmpty) {
                                    customScaffoldMessenger(
                                        context,
                                        Validations.loginHandleError(
                                            emailController: emailController,
                                            passwordController:
                                                passwordController));
                                  } else {
                                    loginController.login(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                    );
                                  }
                                }),
                        getVerticalSpace(1.6.h),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SignupScreen());
                          },
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'Don’t have an account? ',
                              style: AppTextStyles.simpleSmallText.copyWith(
                                  fontSize: 14.px,
                                  color: const Color(0xff444545)),
                            ),
                            TextSpan(
                              text: 'Sign Up',
                              style: AppTextStyles.boldStyle
                                  .copyWith(fontSize: 14.px),
                            ),
                          ])),
                        ),
                        getVerticalSpace(4.4.h),
                        Text(
                          'Login with',
                          style: AppTextStyles.simpleSmallText.copyWith(
                            fontSize: 14.px,
                            color: const Color(0xff444545),
                          ),
                        ),
                        getVerticalSpace(2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/svgs/google.svg'),
                            getHorizentalSpace(1.6.h),
                            SvgPicture.asset('assets/svgs/facebook.svg'),
                            getHorizentalSpace(1.6.h),
                            SvgPicture.asset('assets/svgs/apple.svg'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
      );
}
