import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/view/screens/user_details/progressbar_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../custom_widgets/ui_components.dart';

class MotivationScreen extends StatelessWidget {
  MotivationScreen({super.key});

  final ProgressBarScreenController progressBarScreenController =
      Get.put(ProgressBarScreenController());

  RxList svg = [
    'assets/svgs/motivation_svgs/after monitoring cofee.svg',
    'assets/svgs/motivation_svgs/while commuting.svg',
    'assets/svgs/motivation_svgs/during my lunch break.svg',
    'assets/svgs/motivation_svgs/before going to sleep.svg',
    'assets/svgs/motivation_svgs/any spare time.svg',
  ].obs;

  RxList motivateText = [
    'After monitoring coffee',
    'While commuting',
    'During my lunch break',
    'Before going to sleep',
    'Any spare time',
  ].obs;

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
              'When do you like to find most motivation?',
              textAlign: TextAlign.center,
              style: AppTextStyles.heading,
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
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      selectedIndex.value = index;
                      if (kDebugMode) {
                        print(motivateText[selectedIndex.value]);
                      }
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
                                color: selectedIndex.value == index
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
                            motivateText[index],
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
                progressBarScreenController.nextScreen();
              },
            ),
          ],
        ),
      ),
    );
  }
}
