import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'createNew_Password.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getVerticalSpace(12.5.h),
            Text(
              'Enter the code',
              style: AppTextStyles.boldStyle
                  .copyWith(fontSize: 20.px, color: const Color(0xff000000)),
            ),
            getVerticalSpace(1.6.h),
            Text(
              "We have just sent you a 4-digit code to \nexample@gmail.com",
              style: AppTextStyles.simpleSmallText.copyWith(
                fontSize: 14.px,
                color: const Color(0xff2D3748),
              ),
              textAlign: TextAlign.center,
            ),
            getVerticalSpace(3.6.h),
            OtpTextField(contentPadding: EdgeInsets.symmetric(horizontal: 1.h,),
              numberOfFields: 4,
              showFieldAsBox: true,
          filled: true,
              fillColor: AppColors.whiteColor,
              focusedBorderColor: const Color(0xff828387),
              enabledBorderColor: Colors.white,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              cursorColor: AppColors.blackColor,
              fieldWidth: 6.3.h,
              fieldHeight: 6.3.h,

            ),
            getVerticalSpace(5.1.h),
            customButton(
                horizentalPadding: 7.7.h,
                verticalPadding: .8.h,
                title: "Next",
                onTap: () {
                  Get.to(()=>const CreateNewPassword());
                }),
            getVerticalSpace(2.5.h),
            Text("Didn't receive?",style: AppTextStyles.simpleSmallText,),
            getVerticalSpace(.4.h),
            Text(
              'Resend Code',
              style: AppTextStyles.simpleSmallText.copyWith(
                  fontSize: 12.px,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff272828)),
            ),
          ],
        ),
      ),
    );
  }
}
