import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_journel/view/screens/buy_now_screen.dart';
import 'package:my_journel/view/screens/checkin_screens/checkin_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../controllers/utils/app_colors.dart';
import '../../../controllers/utils/app_styles.dart';
import '../../../custom_widgets/ui_components.dart';
import '../../bottombar.dart';

class GoalsForTomorrowScreen extends StatelessWidget {
  GoalsForTomorrowScreen({super.key});
  CheckInProgressBarController controller =
      Get.put(CheckInProgressBarController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.h),
      child: Column(
        children: [
          Text(
            'Set goals for tomorrow',
            textAlign: TextAlign.center,
            style: AppTextStyles.heading,
          ),
          getVerticalSpace(5.h),
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
                  hintText: 'Describe what you will do tomorrow.',
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
          ),
          // getVerticalSpace(25.h),
          Spacer(),
          CustomNextButton(
            title: 'Next',
            onTap: () {
              Get.to(() => BuyNowScreen());
              // checkInProgressBarScreenController.disposeController();
            },
          ),
        ],
      ),
    );
  }
}
