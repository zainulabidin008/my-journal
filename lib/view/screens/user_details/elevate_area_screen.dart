import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_journel/view/screens/user_details/progressbar_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/getx_controller/user_detail_controller.dart';
import '../../../controllers/utils/app_colors.dart';
import '../../../controllers/utils/app_styles.dart';
import '../../../custom_widgets/ui_components.dart';

class ElevateAreaScreen extends StatefulWidget {
  ElevateAreaScreen({super.key});

  @override
  State<ElevateAreaScreen> createState() => _ElevateAreaScreenState();
}

class _ElevateAreaScreenState extends State<ElevateAreaScreen> {
  final ProgressBarScreenController progressBarScreenController =
      Get.put(ProgressBarScreenController());

  // List areaElevate = [
  //   'Motivation',
  //   'Leadership',
  //   'Management',
  //   'Time-management',
  //   'Parenting',
  //   'Emotions',
  //   'Nutrition',
  //   'Habits',
  //   'Self-confidence',
  //   'Mindfulness',
  //   'Conflict-resolution',
  //   'Leadership skills',
  //   'Self-awareness',
  //   'Resilience',
  //   'Mindset',
  //   'Self-care',
  //   'Communication',
  //   'Exercises',
  //   'Empathy',
  // ].obs;

  late final UserDetailController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(UserDetailController(context));
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        controller.elevate();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loading.value) {
        return Center(
          child: LoadingAnimationWidget.prograssiveDots(
              color: AppColors.blackColor, size: 10.h),
        );
      }
      if (controller.elevations.value == null) {
        return Center(
          child: LoadingAnimationWidget.prograssiveDots(
              color: AppColors.blackColor, size: 10.h),
        );
      }
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
                      for (int index = 0;
                          index < controller.elevations.value!.data.length;
                          index++)
                        GestureDetector(
                          onTap: () {
                            if (progressBarScreenController.selectedAreaElevate
                                .contains(controller
                                    .elevations.value!.data[index].id)) {
                              progressBarScreenController.selectedAreaElevate
                                  .remove(controller
                                      .elevations.value!.data[index].id);
                            } else {
                              progressBarScreenController.selectedAreaElevate
                                  .add(controller
                                      .elevations.value!.data[index].id);
                            }
                            print(progressBarScreenController
                                .selectedAreaElevate
                                .join(', '));
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
                                color: progressBarScreenController
                                        .selectedAreaElevate
                                        .contains(controller
                                            .elevations.value!.data[index].id)
                                    ? Colors.black
                                    : Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: Text(
                                controller.elevations.value!.data[index].title,
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
                  if (progressBarScreenController.selectedAreaElevate.isEmpty) {
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
    });
  }
}
