import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/utils/app_colors.dart';
import '../../../controllers/utils/app_styles.dart';
import '../../../custom_widgets/ui_components.dart';
import 'checkin_bar.dart';

class FeelAboutScreen extends StatelessWidget {
  FeelAboutScreen({super.key});
  final CheckInProgressBarController controller =
      Get.put(CheckInProgressBarController());

  RxList eveningBad = [
    'assets/svgs/feelings_svgs/Group.svg',
    'assets/svgs/feelings_svgs/Group (1).svg',
    'assets/svgs/feelings_svgs/Group (2).svg',
    'assets/svgs/feelings_svgs/Group (3).svg',
    'assets/svgs/feelings_svgs/Group (4).svg',
    'assets/svgs/feelings_svgs/Group (5).svg',
    'assets/svgs/feelings_svgs/Group (6).svg',
    'assets/svgs/feelings_svgs/Group (7).svg',
    'assets/svgs/feelings_svgs/Group (8).svg',
    'assets/svgs/feelings_svgs/Group (9).svg',
    'assets/svgs/feelings_svgs/Group (10).svg',
  ].obs;

  RxList eveningBadName = [
    'Happy',
    'Blessed',
    'Good',
    'Confused',
    'Lucky',
    'Bored',
    'Awkward',
    'Angry',
    'Anxious',
    'Down',
    'Stressed',
  ].obs;
  RxList selectedEveningBadName = [].obs;

  @override
  Widget build(BuildContext context) {
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
            itemCount: eveningBad.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 6 / 7,
            ),
            itemBuilder: (context, index) {
              return Obx(
                () => GestureDetector(
                  onTap: () {
                    if (selectedEveningBadName
                        .contains(eveningBadName[index])) {
                      selectedEveningBadName.remove(eveningBadName[index]);
                    } else {
                      if (selectedEveningBadName.length < 10) {
                        selectedEveningBadName.add(eveningBadName[index]);
                      }
                    }
                    print(selectedEveningBadName.join(', '));
                  },
                  child: Container(
                    // height: 17.h,
                    // width: 14.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.px),
                      color: AppColors.primaryColor,
                      border: Border.all(
                        width: 2.px,
                        color: selectedEveningBadName
                                .contains(eveningBadName[index])
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
                            selectedEveningBadName
                                    .contains(eveningBadName[index])
                                ? Container(
                                    height: 20,
                                    width: 13,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.px),
                                      color: AppColors.blackColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${selectedEveningBadName.indexOf(eveningBadName[index]) + 1}',
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
                        SvgPicture.asset(eveningBad[index]),
                        getVerticalSpace(1.h),
                        Text(
                          eveningBadName[index],
                          style: AppTextStyles.smallText,
                          textAlign: TextAlign.center,
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
              if (selectedEveningBadName.length < 1) {
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
  }
}
