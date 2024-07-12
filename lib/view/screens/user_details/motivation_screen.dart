import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/view/screens/user_details/progressbar_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../controllers/getx_controller/user_detail_controller.dart';
import '../../../controllers/utils/app_colors.dart';
import '../../../custom_widgets/ui_components.dart';
import '../../../model/motivation_model.dart';

class MotivationScreen extends StatelessWidget {
  MotivationScreen({super.key});

  final ProgressBarScreenController progressBarScreenController =
      Get.put(ProgressBarScreenController());

  // RxList svg = [
  //   'assets/svgs/motivation_svgs/after monitoring cofee.svg',
  //   'assets/svgs/motivation_svgs/while commuting.svg',
  //   'assets/svgs/motivation_svgs/during my lunch break.svg',
  //   'assets/svgs/motivation_svgs/before going to sleep.svg',
  //   'assets/svgs/motivation_svgs/any spare time.svg',
  // ].obs;
  //
  // RxList motivateText = [
  //   'After monitoring coffee',
  //   'While commuting',
  //   'During my lunch break',
  //   'Before going to sleep',
  //   'Any spare time',
  // ].obs;

  // final RxList<int> selectedIndexes = <int>[].obs;

  @override
  Widget build(BuildContext context) {
    final UserDetailController controller =
        Get.put(UserDetailController(context));
    controller.motivation();
    return Obx(() {
      if (controller.loading.value) {
        return Center(
          child: LoadingAnimationWidget.prograssiveDots(
              color: AppColors.blackColor, size: 10.h),
        );
      }
      if (controller.motivations.value == null) {
        return Center(
          child: Text("No data available"),
        );
      }
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 2.h),
          child: Column(
            children: [
              SizedBox(height: 5.h),
              Text(
                'When do you like to find most motivation?',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading,
              ),
              SizedBox(height: 4.h),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.motivations.value?.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  print('Length: ${controller.motivations.value?.data.length}');
                  MotivationData motivationData =
                      controller.motivations.value!.data[index];
                  return Obx(
                    () => GestureDetector(
                      onTap: () {
                        progressBarScreenController
                            .selectedMotivationIndex.value = index;
                        progressBarScreenController.selectedMotivation.value =
                            motivationData.id;
                        print(
                            'selected: ${progressBarScreenController.selectedMotivation.value}');
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
                                  color: progressBarScreenController
                                              .selectedMotivationIndex.value ==
                                          index
                                      ? Colors.black
                                      : Colors.transparent,
                                )),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.px),
                              child: Image.network(
                                motivationData.path,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Expanded(
                            child: Text(
                              motivationData.title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 2.h),
              CustomNextButton(
                title: 'Next',
                onTap: () {
                  if (progressBarScreenController
                      .selectedMotivation.isNotEmpty) {
                    progressBarScreenController.nextScreen();
                  } else {
                    customScaffoldMessenger(
                        context, "please select motivation ");
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
