import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../custom_widgets/ui_components.dart';
import '../buy_now_screen.dart';

class StatementBelowScreen extends StatelessWidget {
  StatementBelowScreen({super.key});
  RxBool switchValue = false.obs;

  RxBool personalGrowth = false.obs;
  RxBool keepMovingForward = false.obs;

  @override
  Widget build(BuildContext context) {
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
                // Yes button
                GestureDetector(
                  onTap: () {
                    personalGrowth.value = true;
                    print(personalGrowth.value);
                  },
                  child: Obx(() => Container(
                        height: 2.h,
                        width: 2.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.px),
                          border: Border.all(
                            width: 1,
                            color: personalGrowth.value
                                ? AppColors
                                    .deepBlack // Highlight "Yes" when selected
                                : Colors.grey, // Grey out "Yes" when unselected
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 1.2.h,
                            width: 1.2.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.px),
                              color: personalGrowth.value
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
                    personalGrowth.value = false;
                  },
                  child: Obx(() => Container(
                        height: 2.h,
                        width: 2.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.px),
                          border: Border.all(
                            width: 1,
                            color: !personalGrowth.value
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
                              color: !personalGrowth.value
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
                // Yes button
                GestureDetector(
                  onTap: () {
                    keepMovingForward.value = true;
                    print(personalGrowth.value);
                  },
                  child: Obx(() => Container(
                        height: 2.h,
                        width: 2.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.px),
                          border: Border.all(
                            width: 1,
                            color: keepMovingForward.value
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
                              color: keepMovingForward.value
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
                    keepMovingForward.value = false;
                  },
                  child: Obx(() => Container(
                        height: 2.h,
                        width: 2.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.px),
                          border: Border.all(
                            width: 1,
                            color: !keepMovingForward.value
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
                              color: !keepMovingForward.value
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
            CustomNextButton(
              title: 'Next',
              onTap: () {
                Get.to(() => BuyNowScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
