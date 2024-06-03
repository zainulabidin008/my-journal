import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/utils/app_colors.dart';
import '../../../controllers/utils/app_styles.dart';
import '../../../custom_widgets/ui_components.dart';
import 'checkin_bar.dart';

class SetGoalsScreen extends StatelessWidget {
  SetGoalsScreen({super.key});
  final CheckInProgressBarScreenController checkInProgressBarScreenController =
      Get.put(CheckInProgressBarScreenController());
  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.px, horizontal: 12.px),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.px),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Text(
                    'Today\'s Goal',
                    style: TextStyle(
                      fontSize: 16.px,
                      fontFamily: 'Bold',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
              getVerticalSpace(1.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.px),
                  color: AppColors.whiteColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.px),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget urna vel felis sollicitudin euismod. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin sit amet nunc quis sapien ultrices facilisis. Integer euismod leo ac urna gravida, sit amet feugiat risus interdum. Morbi a lacus ac purus gravida fermentum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam et sem vel mauris pharetra scelerisque. Suspendisse potenti. Cras sagittis, urna in interdum cursus, magna leo convallis metus, id tempus ex lorem eget libero.',
                    style: TextStyle(
                      fontSize: 8.px,
                      fontFamily: 'regular',
                      color: AppColors.simpleSmallTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(3.h),
        child: Column(
          children: [
            Text(
              'Did you achieved your set goals Mohsin?',
              textAlign: TextAlign.center,
              style: AppTextStyles.heading,
            ),
            getVerticalSpace(5.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.px),
                      color: AppColors.whiteColor,
                      border: Border.all(
                        color: AppColors.blackColor,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Yes',
                        style: AppTextStyles.medium,
                      ),
                    ),
                  ),
                ),
                getHorizentalSpace(10.px),
                GestureDetector(
                  onTap: () {
                    showCustomDialog(context);
                  },
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: AppColors.whiteColor,
                    child: Center(
                      child: SvgPicture.asset('assets/svgs/goal1.svg'),
                    ),
                  ),
                ),
                getHorizentalSpace(10.px),
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.px),
                      color: AppColors.whiteColor,
                      border: Border.all(
                        color: AppColors.blackColor,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'No',
                        style: AppTextStyles.medium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Tap here to see\nTodays goal',
              style: TextStyle(
                fontSize: 10.px,
                fontFamily: 'regular',
                color: AppColors.blackColor,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            getVerticalSpace(1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Write about your day...',
                  style: AppTextStyles.medium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            getVerticalSpace(1.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.px),
                color: AppColors.whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Describe your day...',
                    hintStyle: TextStyle(
                      fontSize: 10.px,
                      fontFamily: 'medium',
                      color: AppColors.simpleSmallTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  maxLines: 3,
                ),
              ),
            ),
            getVerticalSpace(2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Talk about your day',
                  style: AppTextStyles.medium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            getVerticalSpace(1.h),
            Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.px),
                color: AppColors.whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.px),
                    child: CircleAvatar(
                      backgroundColor: AppColors.blackColor,
                      radius: 20,
                      child: Center(
                        child: SvgPicture.asset('assets/svgs/mic.svg'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Spacer(),
            getVerticalSpace(25.h),
            CustomNextButton(
              title: 'Next',
              onTap: () {
                checkInProgressBarScreenController.nextScreen();
              },
            ),
          ],
        ),
      ),
    );
  }
}
