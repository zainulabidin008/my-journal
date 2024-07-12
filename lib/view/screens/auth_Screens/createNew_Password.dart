import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/controllers/utils/validations.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../controllers/getx_controller/auth_controller.dart';
import '../../../controllers/utils/constants.dart';
import '../../../controllers/utils/shared_preferences.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  late AuthController resetPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resetPasswordController = Get.put(
      AuthController(context),
    );
  }

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final otp = arguments['otp'] ?? "";
    log('otp: $otp');
    log('id: ${MySharedPreferences.getString(userIdKey)}');
    RxBool isVisible = false.obs;
    RxBool isVisible1 = false.obs;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/pngs/background_image.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getVerticalSpace(12.5.h),
                Text(
                  'Create a new password',
                  style: AppTextStyles.boldStyle.copyWith(
                      fontSize: 20.px, color: const Color(0xff000000)),
                ),
                getVerticalSpace(1.6.h),
                Text(
                  "Your new password must be different from\n previous used passwords.",
                  style: AppTextStyles.simpleSmallText.copyWith(
                    fontSize: 14.px,
                    color: const Color(0xff2D3748),
                  ),
                  textAlign: TextAlign.center,
                ),
                getVerticalSpace(4.2.h),
                customTextFormField(
                  passwordController,
                  'Password',
                  prefixIcon: SvgPicture.asset('assets/svgs/passwordicon.svg'),
                  isObscure: isVisible1.value == true ? false : true,
                  svg: SvgPicture.asset('assets/svgs/lineicon.svg'),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (isVisible1.value == false) {
                        isVisible1.value = true;
                      } else {
                        isVisible1.value = false;
                      }
                    },
                    child: SvgPicture.asset(
                      isVisible1.value == false
                          ? 'assets/svgs/notvisible.svg'
                          : "assets/svgs/visible.svg",
                      colorFilter: const ColorFilter.mode(
                          Color(0xff9E9FA1), BlendMode.srcIn),
                    ),
                  ),
                ),
                getVerticalSpace(1.2.h),
                customTextFormField(
                  confirmPasswordController,
                  'Confirm Password',
                  prefixIcon: SvgPicture.asset('assets/svgs/passwordicon.svg'),
                  isObscure: isVisible.value == true ? false : true,
                  svg: SvgPicture.asset('assets/svgs/lineicon.svg'),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        if (isVisible.value == false) {
                          isVisible.value = true;
                        } else {
                          isVisible.value = false;
                        }
                      },
                      child: SvgPicture.asset(
                        isVisible.value == false
                            ? 'assets/svgs/notvisible.svg'
                            : "assets/svgs/visible.svg",
                        colorFilter: const ColorFilter.mode(
                            Color(0xff9E9FA1), BlendMode.srcIn),
                      )),
                ),
                getVerticalSpace(5.1.h),
                resetPasswordController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                            color: AppColors.blackColor))
                    : customButton(
                        horizentalPadding: 7.7.h,
                        verticalPadding: .8.h,
                        title: "Save",
                        onTap: () {
                          if (Validations.resetAndConfirmPasswordHandleError(
                            passwordController: passwordController,
                            confirmPasswordController:
                                confirmPasswordController,
                          ).isNotEmpty) {
                            customScaffoldMessenger(
                                context,
                                Validations.resetAndConfirmPasswordHandleError(
                                  passwordController: passwordController,
                                  confirmPasswordController:
                                      confirmPasswordController,
                                ));
                          } else {
                            resetPasswordController.resetPasswordApi(
                              otp,
                              confirmPasswordController.text.trim(),
                            );
                          }
                          // Get.to(() => const ProgressBarScreen());
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
