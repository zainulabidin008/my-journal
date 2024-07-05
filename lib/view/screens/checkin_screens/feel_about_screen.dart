import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/getx_controller/checkin_controller.dart';
import '../../../controllers/utils/app_colors.dart';
import '../../../controllers/utils/app_styles.dart';
import '../../../custom_widgets/ui_components.dart';
import '../../../model/checkin_models/feelings_model.dart';
import 'checkin_bar.dart';

class FeelAboutScreen extends StatelessWidget {
  FeelAboutScreen({super.key});
  final CheckInBarController controller = Get.put(CheckInBarController());
  // final HomeController controller = Get.put(HomeController());

  // RxList eveningBad = [
  //   'assets/svgs/feelings_svgs/Group.svg',
  //   'assets/svgs/feelings_svgs/Group (1).svg',
  //   'assets/svgs/feelings_svgs/Group (2).svg',
  //   'assets/svgs/feelings_svgs/Group (3).svg',
  //   'assets/svgs/feelings_svgs/Group (4).svg',
  //   'assets/svgs/feelings_svgs/Group (5).svg',
  //   'assets/svgs/feelings_svgs/Group (6).svg',
  //   'assets/svgs/feelings_svgs/Group (7).svg',
  //   'assets/svgs/feelings_svgs/Group (8).svg',
  //   'assets/svgs/feelings_svgs/Group (9).svg',
  //   'assets/svgs/feelings_svgs/Group (10).svg',
  // ].obs;
  //
  // RxList eveningBadName = [
  //   'Happy',
  //   'Blessed',
  //   'Good',
  //   'Confused',
  //   'Lucky',
  //   'Bored',
  //   'Awkward',
  //   'Angry',
  //   'Anxious',
  //   'Down',
  //   'Stressed',
  // ].obs;

  @override
  Widget build(BuildContext context) {
    final CheckInController feelingsController =
        Get.put(CheckInController(context));
    feelingsController.feelingsDetails();
    return Obx(() {
      if (feelingsController.loading.value) {
        return Center(
          child: LoadingAnimationWidget.prograssiveDots(
              color: AppColors.blackColor, size: 10.h),
        );
      }
      if (feelingsController.moods.value == null) {
        return Center(
          child: Text("No data available"),
        );
      }
      return Padding(
        padding: EdgeInsets.all(5.h),
        child: Column(
          children: [
            Text(
              'And how did you feel about this?',
              textAlign: TextAlign.center,
              style: AppTextStyles.heading,
            ),
            getVerticalSpace(5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select up to 10 Feelings',
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
              itemCount: feelingsController.feelings.value?.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 6 / 7,
              ),
              itemBuilder: (context, index) {
                print(
                    'Length: ${feelingsController.feelings.value?.data.length}');
                FeelingsDatum datum =
                    feelingsController.feelings.value!.data[index];
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (controller.selectedFeelings.contains(datum.id)) {
                        controller.selectedFeelings.remove(datum.id);
                      } else {
                        if (controller.selectedFeelings.length < 10) {
                          controller.selectedFeelings.add(datum.id);
                        }
                      }
                      print(controller.selectedFeelings.join(', '));
                    },
                    child: Container(
                      // height: 17.h,
                      // width: 14.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.px),
                        color: AppColors.primaryColor,
                        border: Border.all(
                          width: 2.px,
                          color: controller.selectedFeelings.contains(datum.id)
                              ? Colors.black
                              : AppColors.whiteColor,
                        ),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              controller.selectedFeelings.contains(datum.id)
                                  ? Container(
                                      height: 20,
                                      width: 13,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.px),
                                        color: AppColors.blackColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${controller.selectedFeelings.indexOf(datum.id) + 1}',
                                          style: TextStyle(
                                            fontSize: 10.px,
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
                          getVerticalSpace(1.5.h),
                          SizedBox(
                            height: 6.h,
                            width: 6.h,
                            child: Image.network(datum.path),
                          ),
                          getVerticalSpace(1.h),
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
                if (controller.selectedFeelings.length < 1) {
                  customScaffoldMessenger(
                      context, 'Please select minimum 1 feeling');
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
