import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:my_journel/view/screens/auth_Screens/login_screen.dart';
import 'package:my_journel/view/screens/auth_Screens/signup_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.whiteColor,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pngs/background_image.jpeg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SvgPicture.asset(
                'assets/svgs/welcomeicon.svg',
                fit: BoxFit.fill,
              ),
            ),
            // getVerticalSpace(16.8.h),
            SizedBox(height: 15.h),
            customButton(
              title: "Create new account",
              horizentalPadding: 11.h,
              onTap: () {
                Get.offAll(() => SignupScreen());
              },
            ),
            getVerticalSpace(1.4.h),
            GestureDetector(
              onTap: () {
                Get.offAll(() => const LoginScreen());
              },
              child: Text(
                'Already have account?',
                style: AppTextStyles.simpleSmallText.copyWith(
                  fontSize: 14.px,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
