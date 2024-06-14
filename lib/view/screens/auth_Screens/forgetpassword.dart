import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/controllers/utils/validations.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:my_journel/view/screens/auth_Screens/login_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../controllers/getx_controller/auth_controller.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late AuthController forgotController;
  @override
  void initState() {
    super.initState();
    forgotController = Get.put(
      AuthController(context),
    );
  }

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getVerticalSpace(12.5.h),
            Text(
              'Reset Your Password',
              style: AppTextStyles.boldStyle
                  .copyWith(fontSize: 20.px, color: const Color(0xff000000)),
            ),
            getVerticalSpace(.8.h),
            Text(
              "Enter your email and we'll send you a link to reset \nyour password.",
              style: AppTextStyles.simpleSmallText.copyWith(
                fontSize: 14.px,
                color: const Color(0xff2D3748),
              ),
              textAlign: TextAlign.center,
            ),
            getVerticalSpace(7.4.h),
            customTextFormField(emailController, 'Email',
                prefixIcon: SvgPicture.asset('assets/svgs/emailicon.svg'),
                isObscure: false,
                svg: SvgPicture.asset('assets/svgs/lineicon.svg')),
            getVerticalSpace(4.6.h),
            Obx(
              () => forgotController.resendIsLoading.value
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
                        String error = Validations.resetPasswordHandleError(
                            emailController: emailController);
                        if (error.isNotEmpty) {
                          customScaffoldMessenger(
                              context,
                              Validations.resetPasswordHandleError(
                                  emailController: emailController));
                        } else {
                          forgotController
                              .forgotPassword(emailController.text.trim());
                        }
                      }),
            ),
            getVerticalSpace(1.3.h),
            GestureDetector(
              onTap: () {
                Get.to(() => const LoginScreen());
              },
              child: Text(
                'Sign-In',
                style: AppTextStyles.simpleSmallText.copyWith(
                    fontSize: 12.px,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff272828)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
