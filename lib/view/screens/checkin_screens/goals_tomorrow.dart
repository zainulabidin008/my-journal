import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_journel/view/screens/checkin_screens/checkin_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/getx_controller/checkin_controller.dart';
import '../../../controllers/utils/app_colors.dart';
import '../../../controllers/utils/app_styles.dart';
import '../../../custom_widgets/ui_components.dart';

class GoalsForTomorrowScreen extends StatelessWidget {
  GoalsForTomorrowScreen({super.key});
  final CheckInBarController controller = Get.put(CheckInBarController());

  @override
  Widget build(BuildContext context) {
    final CheckInController checkInController = Get.put(
      CheckInController(context),
    );
    print("Note Id: ${controller.noteId.value}");
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
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
                  controller: controller.tomorrowGoalController,
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
            Spacer(),
            Obx(() {
              return checkInController.loading.value
                  ? Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                          color: AppColors.blackColor, size: 7.h),
                    )
                  : CustomNextButton(
                      title: 'Next',
                      onTap: () async {
                        if (controller.tomorrowGoalController.text.isEmpty) {
                          customScaffoldMessenger(
                              context, 'your day description is not be empty');
                        } else {
                          await checkInController
                              .sendVoice(File(controller.audioPath.value));
                        }
                        // Get.offAll(() => BuyNowScreen());
                      },
                    );
            })
          ],
        ),
      ),
    );
  }
}
