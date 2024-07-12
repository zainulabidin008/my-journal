import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/getx_controller/getallapis_controller.dart';
import '../controllers/utils/app_colors.dart';
import '../controllers/utils/app_styles.dart';
import '../custom_widgets/ui_components.dart';

class GoalScreen extends StatefulWidget {
  GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final TextEditingController lifeGoals = TextEditingController();
  final TextEditingController yearOfGoals = TextEditingController();
  late GetAllApis controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(GetAllApis(context));
    controller.getHeading();
  }

  @override
  Widget build(BuildContext context) {
    // final GetAllApis controller = Get.put(GetAllApis(context));
    // controller.getHeading();
    log("goal name: ${controller.getGoalsHeading.value?.data.goal}");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pngs/background_image.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 10.5.h,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(3.h),
                  bottomRight: Radius.circular(3.h),
                ),
                color: AppColors.blackColor,
              ),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(''),
                    controller.loading.value
                        ? LoadingAnimationWidget.prograssiveDots(
                            color: AppColors.whiteColor, size: 5.h)
                        : Text(
                            controller.getGoalsHeading.value!.data.goal,
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
            ),
            // getVerticalSpace(5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 3.h),
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
                      controller: lifeGoals,
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
                      controller: yearOfGoals,
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
        ),
      ),
    );
  }
}
