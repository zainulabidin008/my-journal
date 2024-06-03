import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/utils/app_colors.dart';
import '../controllers/utils/app_styles.dart';
import '../custom_widgets/ui_components.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10.5.h,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.h),
            color: AppColors.blackColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(''),
              Text(
                'Long term goals',
                style: TextStyle(
                  fontSize: 16.px,
                  fontFamily: 'medium',
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // getVerticalSpace(5.h),
        Padding(
          padding: EdgeInsets.all(5.h),
          child: Column(
            children: [
              Text(
                'Write down your life goals',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading,
              ),
              getVerticalSpace(2.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.px),
                  color: AppColors.whiteColor,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write here ...',
                    contentPadding: EdgeInsets.all(12),
                    hintStyle: TextStyle(
                      fontSize: 10.px,
                      fontFamily: 'medium',
                      color: AppColors.simpleSmallTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  maxLines: 6,
                ),
              ),
              getVerticalSpace(3.h),
              Text(
                'Write down your goals for this year',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading,
              ),
              getVerticalSpace(2.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.px),
                  color: AppColors.whiteColor,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write here ...',
                    contentPadding: EdgeInsets.all(12),
                    hintStyle: TextStyle(
                      fontSize: 10.px,
                      fontFamily: 'medium',
                      color: AppColors.simpleSmallTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  maxLines: 6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
