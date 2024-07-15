import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_journel/controllers/getx_controller/auth_controller.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/view/screens/auth_Screens/login_screen.dart';
import 'package:my_journel/view/screens/user_details/progressbar_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/getx_controller/user_detail_controller.dart';
import '../../../custom_widgets/ui_components.dart';

class StatementBelowScreen extends StatelessWidget {
  StatementBelowScreen({super.key});

  final ProgressBarScreenController progressBarScreenController =
      Get.put(ProgressBarScreenController());

  @override
  Widget build(BuildContext context) {
    final UserDetailController userDetailController =
        Get.put(UserDetailController(context));
    final AuthController authController = Get.put(AuthController(context));
    log('email: ${authController.email.value}');
    log('password: ${authController.confirmPassword.value}');
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 2.h),
        child: Column(
          children: [
            SizedBox(height: 5.h),
            SvgPicture.asset('assets/svgs/question-mark.svg'),
            SizedBox(height: 4.h),
            Text(
              "Do you agree with the statement below?",
              textAlign: TextAlign.center,
              style: AppTextStyles.heading,
            ),
            SizedBox(height: 7.h),
            Text(
              "I believe in learning and personal growth, but it's hard to stay motivated without a clear plan.",
              textAlign: TextAlign.start,
              style: AppTextStyles.medium,
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    progressBarScreenController.personalGrowth.value = true;
                    if (kDebugMode) {
                      print(progressBarScreenController.personalGrowth.value);
                    }
                  },
                  child: Obx(() => Container(
                        height: 2.h,
                        width: 2.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.px),
                          border: Border.all(
                            width: 1,
                            color:
                                progressBarScreenController.personalGrowth.value
                                    ? AppColors.deepBlack
                                    : Colors.grey,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 1.2.h,
                            width: 1.2.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.px),
                              color: progressBarScreenController
                                      .personalGrowth.value
                                  ? AppColors.blackColor
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      )),
                ),
                getHorizentalSpace(1.h),
                Text(
                  'Yes',
                  style: AppTextStyles.smallText,
                ),
                getHorizentalSpace(2.h),
                GestureDetector(
                  onTap: () {
                    progressBarScreenController.personalGrowth.value = false;
                    if (kDebugMode) {
                      print(progressBarScreenController.personalGrowth.value);
                    }
                  },
                  child: Obx(() => Container(
                        height: 2.h,
                        width: 2.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.px),
                          border: Border.all(
                            width: 1,
                            color: !progressBarScreenController
                                    .personalGrowth.value
                                ? AppColors.deepBlack
                                : Colors.grey,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 1.2.h,
                            width: 1.2.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.px),
                              color: !progressBarScreenController
                                      .personalGrowth.value
                                  ? AppColors.blackColor
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      )),
                ),
                getHorizentalSpace(1.h),
                Text(
                  'No',
                  style: AppTextStyles.smallText,
                ),
              ],
            ),
            getVerticalSpace(2.5.h),
            Text(
              "I Sometimes I need a friendly push to keep moving forward.",
              textAlign: TextAlign.start,
              style: AppTextStyles.medium,
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    progressBarScreenController.keepMovingForward.value = true;
                    if (kDebugMode) {
                      print(
                          progressBarScreenController.keepMovingForward.value);
                    }
                  },
                  child: Obx(() => Container(
                        height: 2.h,
                        width: 2.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.px),
                          border: Border.all(
                            width: 1,
                            color: progressBarScreenController
                                    .keepMovingForward.value
                                ? AppColors.deepBlack
                                : Colors.grey,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 1.2.h,
                            width: 1.2.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.px),
                              color: progressBarScreenController
                                      .keepMovingForward.value
                                  ? AppColors.blackColor
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      )),
                ),
                getHorizentalSpace(1.h),
                Text(
                  'Yes',
                  style: AppTextStyles.smallText,
                ),
                getHorizentalSpace(2.h),
                GestureDetector(
                  onTap: () {
                    progressBarScreenController.keepMovingForward.value = false;
                    if (kDebugMode) {
                      print(
                          progressBarScreenController.keepMovingForward.value);
                    }
                  },
                  child: Obx(() => Container(
                        height: 2.h,
                        width: 2.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.px),
                          border: Border.all(
                            width: 1,
                            color: !progressBarScreenController
                                    .keepMovingForward.value
                                ? AppColors.deepBlack
                                : Colors.grey,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 1.2.h,
                            width: 1.2.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.px),
                              color: !progressBarScreenController
                                      .keepMovingForward.value
                                  ? AppColors.blackColor
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      )),
                ),
                getHorizentalSpace(1.h),
                Text(
                  'No',
                  style: AppTextStyles.smallText,
                ),
              ],
            ),
            Spacer(),
            Obx(() {
              return userDetailController.loading.value
                  ? Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                          color: AppColors.blackColor, size: 7.h),
                    )
                  : CustomNextButton(
                      title: 'Next',
                      onTap: () async {
                        await userDetailController.updateUser(
                          progressBarScreenController.selectedGender.value,
                          progressBarScreenController.selectedAge.value,
                          progressBarScreenController.selectedGoals,
                          progressBarScreenController.selectedAreaElevate,
                          progressBarScreenController.growthTime.value,
                          progressBarScreenController.selectedMotivation.value,
                          progressBarScreenController.switchValue.value,
                          progressBarScreenController.personalGrowth.value,
                          progressBarScreenController.keepMovingForward.value,
                        );
                        // Get.to(() => LoginScreen());
                      },
                    );
            }),
          ],
        ),
      ),
    );
  }
}

// print(
//     "Gender: ${progressBarScreenController.selectedGender.value}");
// print("Age: ${progressBarScreenController.selectedAge.value}");
// print("Goals: ${progressBarScreenController.selectedGoals}");
// print(
//     "Elevate: ${progressBarScreenController.selectedAreaElevate}");
// print(
//     "Growth Time: ${progressBarScreenController.growthTime.value}");
// print(
//     "Motivation: ${progressBarScreenController.selectedMotivation.value}");
// print(
//     "Staying on track: ${progressBarScreenController.switchValue.value}");
// print(
//     "Personal growth: ${progressBarScreenController.personalGrowth.value}");
// print(
//     "Keep Moving Forward: ${progressBarScreenController.keepMovingForward.value}");

// Get.to(
//   () => MyBottomBar(),
// );
