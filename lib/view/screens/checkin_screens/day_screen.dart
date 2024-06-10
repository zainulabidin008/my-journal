import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'checkin_bar.dart';

class DayScreen extends StatelessWidget {
  DayScreen({super.key});
  final CheckInProgressBarController controller =
      Get.put(CheckInProgressBarController());

  RxList faces = [
    'assets/svgs/faces/angry.svg',
    'assets/svgs/faces/sad.svg',
    'assets/svgs/faces/Wonderful.svg',
    'assets/svgs/faces/Enjoyable.svg',
    'assets/svgs/faces/Busy.svg',
    'assets/svgs/faces/Lazy.svg',
  ].obs;

  RxList faceName = [
    'Angry',
    'Sad',
    'Wonderful',
    'Enjoyable',
    'Busy',
    'Lazy',
  ].obs;

  RxInt selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
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
            itemCount: faces.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 5 / 6,
            ),
            itemBuilder: (context, index) {
              return Obx(
                () => GestureDetector(
                  onTap: () {
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
                          color: selectedIndex.value == index
                              ? Colors.black
                              : Colors.white,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(faces[index]),
                          getVerticalSpace(2.5.h),
                          Text(
                            faceName[index],
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
  }
}
