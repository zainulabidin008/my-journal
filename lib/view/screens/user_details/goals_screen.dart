import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/view/screens/user_details/progressbar_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../custom_widgets/ui_components.dart';

class GoalsScreen extends StatelessWidget {
  final ProgressBarScreenController progressBarScreenController =
      Get.put(ProgressBarScreenController());

  GoalsScreen({super.key});
  RxList svg = [
    'assets/svgs/close knit family.svg',
    'assets/svgs/achieve-life-balance.svg',
    'assets/svgs/successful career.svg',
    'assets/svgs/Become confident.svg',
    'assets/svgs/Increase Productivity.svg',
    'assets/svgs/Self employee.svg',
  ].obs;

  RxList goals = [
    'Built a close-knit family',
    'Achieve  life balance',
    'Have a successful career',
    'Become confident',
    'Increase Productivity',
    'Self employee',
  ].obs;

  RxList selectedGoals = [].obs;

  RxInt selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 2.h),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Text(
              'What are your goals?',
              style: AppTextStyles.heading,
            ),
            SizedBox(height: 4.px),
            Text(
              textAlign: TextAlign.center,
              'Choose up to 3 goals for more precise personalization',
              style: AppTextStyles.regularStyle,
            ),
            SizedBox(height: 4.h),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: svg.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1.0, // Aspect ratio of each grid item
              ),
              itemBuilder: (context, index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (selectedGoals.contains(goals[index])) {
                        selectedGoals.remove(goals[index]);
                      } else {
                        if (selectedGoals.length < 3) {
                          selectedGoals.add(goals[index]);
                        }
                      }
                      print(selectedGoals.join(', '));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 12.h,
                          width: 17.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.px),
                              color: Colors.white,
                              border: Border.all(
                                width: 2.px,
                                color: selectedGoals.contains(goals[index])
                                    ? Colors.black
                                    : Colors.transparent,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: SvgPicture.asset(svg[index]),
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Expanded(
                          child: Text(
                            goals[index],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            CustomNextButton(
              title: 'Next',
              onTap: () {
                if (selectedGoals.length < 3) {
                  customScaffoldMessenger(
                      context, 'please select minimum three goals');
                } else if (selectedGoals.length >= 3) {
                  progressBarScreenController.nextScreen();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
