import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/getx_controller/checkin_controller.dart';
import '../../../controllers/utils/app_colors.dart';
import '../../../controllers/utils/app_styles.dart';
import '../../../custom_widgets/ui_components.dart';
import '../../../model/checkin_models/activities_model.dart';
import 'checkin_bar.dart';

class EveningBadScreen extends StatelessWidget {
  EveningBadScreen({super.key});
  final CheckInBarController controller = Get.put(CheckInBarController());
  // final HomeController controller = Get.put(HomeController());

  // RxList eveningBad = [
  //   'assets/svgs/some_what_bad_svgs/layer1.svg',
  //   'assets/svgs/some_what_bad_svgs/Capa_1.svg',
  //   'assets/svgs/some_what_bad_svgs/Capa_1 (1).svg',
  //   'assets/svgs/some_what_bad_svgs/Capa_1 (2).svg',
  //   'assets/svgs/some_what_bad_svgs/Capa_1 (3).svg',
  //   'assets/svgs/some_what_bad_svgs/Capa_1 (4).svg',
  //   'assets/svgs/some_what_bad_svgs/flat.svg',
  //   'assets/svgs/some_what_bad_svgs/flat (1).svg',
  //   'assets/svgs/some_what_bad_svgs/flat (2).svg',
  //   'assets/svgs/some_what_bad_svgs/Group.svg',
  //   'assets/svgs/some_what_bad_svgs/Group (1).svg',
  //   'assets/svgs/some_what_bad_svgs/Layer_1.svg',
  //   'assets/svgs/some_what_bad_svgs/Layer_1 (1).svg',
  //   'assets/svgs/some_what_bad_svgs/Layer_2_00000162328141622917007760000011986456663703078795_.svg',
  //   'assets/svgs/some_what_bad_svgs/Meditation.svg',
  //   'assets/svgs/some_what_bad_svgs/game.svg',
  // ].obs;
  //
  // RxList eveningBadName = [
  //   'Work',
  //   'Family',
  //   'Friends',
  //   'School',
  //   'Relation',
  //   'Traveling',
  //   'Food',
  //   'Exercise',
  //   'Health',
  //   'Hobbies',
  //   'Gaming',
  //   'Weather',
  //   'Relaxing',
  //   'Sleep',
  //   'Shopping',
  //   'Music',
  // ].obs;

  @override
  Widget build(BuildContext context) {
    final CheckInController activitiesController =
        Get.put(CheckInController(context));
    activitiesController.activitiesDetails();
    return Obx(() {
      if (activitiesController.loading.value) {
        return Center(
          child: LoadingAnimationWidget.prograssiveDots(
              color: AppColors.blackColor, size: 10.h),
        );
      }
      if (activitiesController.moods.value == null) {
        return Center(
          child: Text("No data available"),
        );
      }
      return Padding(
        padding: EdgeInsets.all(5.h),
        child: Column(
          children: [
            Text(
              'Hmm... What made your evening somewhat bad?',
              textAlign: TextAlign.center,
              style: AppTextStyles.heading,
            ),
            getVerticalSpace(5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select up to 10 Activates',
                  style: TextStyle(
                    fontSize: 14.px,
                    fontFamily: 'regular',
                    color: AppColors.blackColor,
                  ),
                ),
                Text(
                  '1/10',
                  style: TextStyle(
                    fontSize: 14.px,
                    fontFamily: 'regular',
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
            getVerticalSpace(1.h),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  activitiesController.activities.value?.data.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 2 / 3,
              ),
              itemBuilder: (context, index) {
                print(
                    'Activities Length: ${activitiesController.activities.value?.data.length}');
                Datum datum =
                    activitiesController.activities.value!.data[index];
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (controller.activities.contains(datum.id)) {
                        controller.activities.remove(datum.id);
                      } else {
                        if (controller.activities.length < 10) {
                          controller.activities.add(datum.id);
                        }
                      }
                      print(controller.activities.join(', '));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            8.0), // Changed 8.px to 8.0 for simplicity
                        color: AppColors.primaryColor,
                        border: Border.all(
                          width: 2.0, // Changed 2.px to 2.0 for simplicity
                          color: controller.activities.contains(datum.id)
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              controller.activities.contains(datum.id)
                                  ? Container(
                                      height: 20,
                                      width: 13,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: AppColors.blackColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${controller.activities.indexOf(datum.id) + 1}',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            fontFamily: 'regular',
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                          SizedBox(
                              height: 5.h,
                              width: 5.h,
                              child: Image.network(datum.path)),
                          SizedBox(
                              height:
                                  8.0), // Changed getVerticalSpace(1.h) to SizedBox for simplicity
                          Text(
                            datum.title,
                            style: AppTextStyles.smallText,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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
                if (controller.activities.length < 1) {
                  customScaffoldMessenger(
                      context, 'Please select minimum 1 items');
                } else {
                  controller.nextScreen();
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
