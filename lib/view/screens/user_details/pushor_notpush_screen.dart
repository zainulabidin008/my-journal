import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/view/screens/user_details/progressbar_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../custom_widgets/ui_components.dart';

class PushOrNotPushScreen extends StatelessWidget {
  PushOrNotPushScreen({super.key});

  final ProgressBarScreenController progressBarScreenController =
      Get.put(ProgressBarScreenController());

  RxBool switchValue = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 2.h),
        child: Column(
          children: [
            SizedBox(height: 5.h),
            SvgPicture.asset('assets/svgs/pushor-notpush.svg'),
            SizedBox(height: 2.2.h),
            Text(
              'When do you like to find most motivation?',
              textAlign: TextAlign.center,
              style: AppTextStyles.heading,
            ),
            SizedBox(height: 4.px),
            Text(
              'You choose!',
              style: AppTextStyles.regularStyle,
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Staying on track',
                  style: AppTextStyles.subtitle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => SizedBox(
                    height: 10,
                    child: Transform.scale(
                      scale: 0.6,
                      child: CupertinoSwitch(
                        thumbColor: AppColors.blackColor,
                        onLabelColor: Colors.grey,
                        value: switchValue.value,
                        onChanged: (value) {
                          switchValue.value = value;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Staying on track',
                  style: AppTextStyles.subtitleGrey,
                ),
              ],
            ),
            Spacer(),
            CustomNextButton(
              title: 'Next',
              onTap: () {
                progressBarScreenController.nextScreen();
              },
            ),
          ],
        ),
      ),
    );
  }
}
