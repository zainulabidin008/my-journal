import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:my_journel/view/screens/auth_Screens/forgetpassword.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
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
                    prefixIcon: SvgPicture.asset('assets/svgs/emailicon.svg'),
                    isObscure: false,
                    svg: SvgPicture.asset('assets/svgs/lineicon.svg')),
                getVerticalSpace(2.h),
                customTextFormField(passwordController, 'Password',
                    prefixIcon: SvgPicture.asset('assets/svgs/passwordicon.svg'),
                    isObscure: false,
                    svg: SvgPicture.asset('assets/svgs/lineicon.svg')),
                getVerticalSpace(.8.h),
               GestureDetector(onTap: () {
                 Get.to(()=>const ForgetPassword());

               },
                 child: Align(alignment: Alignment.centerRight,
                   child: Text(
                      'Forgot password?',
                      style: AppTextStyles.simpleSmallText
                          .copyWith(fontSize: 12.px, fontWeight: FontWeight.w600,color: const Color(0xff181919)),
                    ),
                 ),
               ),
                getVerticalSpace(6.6.h),
                customButton(
                horizentalPadding: 18.h,
                    title: "Login",
                    onTap: (){
        
                    }
                ),
                getVerticalSpace(1.6.h),
                RichText(text: TextSpan(children: [
                  TextSpan(text: 'Don’t have an account? ',style: AppTextStyles.simpleSmallText.copyWith(fontSize: 14.px,color: const Color(0xff444545)),),
                  TextSpan(text: 'Sign Up',style: AppTextStyles.boldStyle.copyWith(fontSize: 14.px),),
                ])),
                getVerticalSpace(4.4.h),
                Text('Login with',style: AppTextStyles.simpleSmallText.copyWith(fontSize: 14.px,color: const Color(0xff444545)),),
                getVerticalSpace(2.h),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SvgPicture.asset('assets/svgs/google.svg'),
                  getHorizentalSpace(1.6.h),
                  SvgPicture.asset('assets/svgs/facebook.svg'),
                  getHorizentalSpace(1.6.h),

                  SvgPicture.asset('assets/svgs/apple.svg'),
                ],)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
