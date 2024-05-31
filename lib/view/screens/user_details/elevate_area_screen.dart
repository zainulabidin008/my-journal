import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_journel/view/screens/user_details/progressbar_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/utils/app_colors.dart';
import '../../../controllers/utils/app_styles.dart';
import '../../../custom_widgets/ui_components.dart';

class ElevateAreaScreen extends StatelessWidget {
  ElevateAreaScreen({super.key});
  final ProgressBarScreenController progressBarScreenController =
      Get.put(ProgressBarScreenController());

  List areaElevate = [
    'Motivation',
    'Leadership',
    'Management',
    'Time-management',
    'Parenting',
    'Emotions',
    'Nutrition',
    'Habits',
    'Self-confidence',
    'Mindfulness',
    'Conflict-resolution',
    'Leadership skills',
    'Self-awareness',
    'Resilience',
    'Mindset',
    'Self-care',
    'Communication',
    'Exercises',
    'Empathy',
  ].obs;
  RxList selectedAreaElevate = [].obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 2.h),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Text(
              'Choose areas  you’d like to elevate',
              style: AppTextStyles.heading,
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                return Wrap(
                  spacing: 20.px, // gap between adjacent chips
                  runSpacing: 20.px, // gap between lines
                  children: [
                    for (int index = 0; index < areaElevate.length; index++)
                      GestureDetector(
                        onTap: () {
                          if (selectedAreaElevate
                              .contains(areaElevate[index])) {
                            selectedAreaElevate.remove(areaElevate[index]);
                          } else {
                            selectedAreaElevate.add(areaElevate[index]);
                          }
                          print(selectedAreaElevate.join(', '));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.white,
                            border: Border.all(
                              color: selectedAreaElevate
                                      .contains(areaElevate[index])
                                  ? Colors.black
                                  : Colors.white,
                              width: 2.0,
                            ),
                          ),
                          child: Text(areaElevate[index],
                              style: AppTextStyles.simpleSmallText),
                        ),
                      ),
                  ],
                );
              }),
            ),
            Spacer(),
            CustomNextButton(
              title: 'Next',
              onTap: () {
                if (selectedAreaElevate.isEmpty) {
                  customScaffoldMessenger(context, 'Please select the area');
                } else {
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
