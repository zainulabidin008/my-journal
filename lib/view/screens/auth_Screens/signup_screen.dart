import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../buy_now_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  'Sign Up',
                  style: AppTextStyles.boldStyle,
                ),
                getVerticalSpace(4.h),
                customTextFormField(
                  firstNameController,
                  'First Name',
                  prefixIcon: SvgPicture.asset('assets/svgs/person.svg'),
                  isObscure: false,
                  svg: SvgPicture.asset('assets/svgs/lineicon.svg'),
                ),
                getVerticalSpace(2.h),
                customTextFormField(
                  lastNameController,
                  'Last Name',
                  prefixIcon: SvgPicture.asset('assets/svgs/person.svg'),
                  isObscure: false,
                  svg: SvgPicture.asset('assets/svgs/lineicon.svg'),
                ),
                getVerticalSpace(2.h),
                customTextFormField(
                  emailController,
                  'Email',
                  prefixIcon: SvgPicture.asset('assets/svgs/emailicon.svg'),
                  isObscure: false,
                  svg: SvgPicture.asset('assets/svgs/lineicon.svg'),
                ),
                getVerticalSpace(2.h),
                customTextFormField(
                  passwordController,
                  'Password',
                  prefixIcon: SvgPicture.asset('assets/svgs/emailicon.svg'),
                  isObscure: false,
                  svg: SvgPicture.asset('assets/svgs/lineicon.svg'),
                ),
                getVerticalSpace(2.h),
                customTextFormField(
                  confirmPasswordController,
                  'Confirmed Password',
                  prefixIcon: SvgPicture.asset('assets/svgs/passwordicon.svg'),
                  isObscure: false,
                  svg: SvgPicture.asset('assets/svgs/lineicon.svg'),
                ),
                getVerticalSpace(3.5.h),
                customButton(
                    horizentalPadding: 16.h,
                    title: "Sign up",
                    onTap: () {
                      Get.to(() => BuyNowScreen());
                    }),
                getVerticalSpace(1.6.h),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'I already have an account ',
                    style: AppTextStyles.simpleSmallText.copyWith(
                      fontSize: 14.px,
                      color: const Color(0xff444545),
                    ),
                  ),
                  TextSpan(
                    text: 'Log In',
                    style: AppTextStyles.boldStyle.copyWith(fontSize: 14.px),
                  ),
                ])),
                getVerticalSpace(3.h),
                Text(
                  'Signup with',
                  style: AppTextStyles.simpleSmallText.copyWith(
                      fontSize: 14.px, color: const Color(0xff444545)),
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
                ),
                getVerticalSpace(2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
