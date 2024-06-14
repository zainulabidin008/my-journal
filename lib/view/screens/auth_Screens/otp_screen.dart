import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/getx_controller/auth_controller.dart';
import 'createNew_Password.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final String type;
  const OtpScreen({super.key, required this.email, required this.type});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late AuthController controller;
  String otp = "";

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      AuthController(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Provide a default value if Get.arguments is null
    final arguments = Get.arguments ?? {};
    final userEmail = arguments['userEmail'] ?? widget.email;

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
              "We have just sent you a 4-digit code to \n $userEmail",
              style: AppTextStyles.simpleSmallText.copyWith(
                fontSize: 14.px,
                color: const Color(0xff2D3748),
              ),
              textAlign: TextAlign.center,
            ),
            getVerticalSpace(3.6.h),
            OtpTextField(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 1.h,
              ),
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
              onSubmit: (code) {
                setState(() {
                  otp = code;
                });
              },
            ),
            getVerticalSpace(5.1.h),
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.blackColor,
                      ),
                    )
                  : customButton(
                      horizentalPadding: 7.7.h,
                      verticalPadding: .8.h,
                      title: "Next",
                      onTap: () {
                        if (otp.length == 4) {
                          if (widget.type.toString() == "email") {
                            controller.verifyEmailOtp(otp, widget.type);
                          } else {
                            controller.verifyPasswordOtp(otp, widget.type);
                          }
                        } else {
                          customScaffoldMessenger(
                            context,
                            'Please enter the 4-digit OTP',
                          );
                        }
                      }),
            ),
            getVerticalSpace(2.5.h),
            Text(
              "Didn't receive?",
              style: AppTextStyles.simpleSmallText,
            ),
            getVerticalSpace(.4.h),
            Obx(
              () => controller.resendIsLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                          color: AppColors.blackColor))
                  : GestureDetector(
                      onTap: () {
                        if (widget.type.toString() == "email") {
                          controller.verifyEmail(userEmail);
                        } else {
                          controller.forgotPassword(userEmail);
                        }
                      },
                      child: Text(
                        'Resend Code',
                        style: AppTextStyles.simpleSmallText.copyWith(
                            fontSize: 12.px,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff272828)),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
