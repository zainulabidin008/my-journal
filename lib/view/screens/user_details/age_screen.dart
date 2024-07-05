import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/view/screens/user_details/progressbar_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../custom_widgets/ui_components.dart';

class AgeScreen extends StatelessWidget {
  final ProgressBarScreenController progressBarScreenController =
      Get.put(ProgressBarScreenController());

  AgeScreen({super.key});
  RxList age = [
    '18-24',
    '25-34',
    '35-44',
    '45-54',
    '55+',
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 2.h),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Text(
              'What is your age ?',
              style: AppTextStyles.heading,
            ),
            SizedBox(height: 4.px),
            Text(
              'Please select your age',
              style: AppTextStyles.regularStyle,
            ),
            SizedBox(height: 4.h),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: age.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      progressBarScreenController.selectedIndex.value = index;
                      progressBarScreenController.selectedAge.value =
                          age[index];
                      print(
                          'selectedAge: ${progressBarScreenController.selectedAge}');
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      child: Container(
                        height: 51.px,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.px),
                          border: Border.all(
                              width: 2.px,
                              color: progressBarScreenController
                                          .selectedIndex.value ==
                                      index
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        child: Center(
                          child: Text(
                            age[index],
                            style: AppTextStyles.heading,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            CustomNextButton(
              title: 'Next',
              onTap: () {
                if (progressBarScreenController.selectedAge.isNotEmpty) {
                  progressBarScreenController.nextScreen();
                } else {
                  customScaffoldMessenger(context, "please select your age");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
