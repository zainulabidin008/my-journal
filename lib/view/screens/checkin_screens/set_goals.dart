import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/utils/app_colors.dart';
import '../../../controllers/utils/app_styles.dart';
import '../../../custom_widgets/ui_components.dart';

class SetGoalsScreen extends StatelessWidget {
  SetGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(5.h),
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
                CircleAvatar(
                  radius: 17,
                  backgroundColor: AppColors.whiteColor,
                  child: Center(
                    child: SvgPicture.asset('assets/svgs/goal1.svg'),
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
