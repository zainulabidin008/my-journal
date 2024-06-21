import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_journel/controllers/getx_controller/checkin_controller.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../model/checkin_models/moodes_model.dart';
import 'checkin_bar.dart';

class DayScreen extends StatelessWidget {
  DayScreen({super.key});

  final CheckInBarController controller = Get.put(CheckInBarController());
  // final HomeController controller = Get.put(HomeController());

  // RxList faces = [
  //   'assets/svgs/faces/angry.svg',
  //   'assets/svgs/faces/sad.svg',
  //   'assets/svgs/faces/Wonderful.svg',
  //   'assets/svgs/faces/Enjoyable.svg',
  //   'assets/svgs/faces/Busy.svg',
  //   'assets/svgs/faces/Lazy.svg',
  // ].obs;
  //
  // RxList faceName = [
  //   'Angry',
  //   'Sad',
  //   'Wonderful',
  //   'Enjoyable',
  //   'Busy',
  //   'Lazy',
  // ].obs;

  RxInt selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    final CheckInController moodsController =
        Get.put(CheckInController(context));
    moodsController.moodsDetails();
    return Obx(() {
      if (moodsController.loading.value) {
        return Center(
          child: LoadingAnimationWidget.prograssiveDots(
              color: AppColors.blackColor, size: 10.h),
        );
      }
      if (moodsController.moods.value == null) {
        return Center(
          child: Text("No data available"),
        );
      }
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 7.h),
        child: Column(
          children: [
            Text(
              'How was your day Mohsin ?',
              style: AppTextStyles.heading,
            ),
            getVerticalSpace(5.h),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: moodsController.moods.value?.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 5 / 6,
              ),
              itemBuilder: (context, index) {
                print('Length: ${moodsController.moods.value?.data.length}');
                Datum datum = moodsController.moods.value!.data[index];
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.moodsId.value = datum.id;
                      log('Selected ID: ${controller.moodsId.value}');
                      selectedIndex.value = index;
                    },
                    child: Container(
                      height: 17.h,
                      // width: 14.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.px),
                        color: AppColors.primaryColor,
                        border: Border.all(
                          width: 2.px,
                          color: controller.moodsId.value == datum.id
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 9.h,
                              width: 9.h,
                              child: Image.network(datum.path),
                            ),
                            getVerticalSpace(2.5.h),
                            Text(
                              datum.title,
                              textAlign: TextAlign.center,
                            ),
                          ],
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
                controller.nextScreen();
              },
            ),
          ],
        ),
      );
    });
  }
}
