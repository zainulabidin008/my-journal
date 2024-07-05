import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/controllers/utils/shared_preferences.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:my_journel/view/screens/welcome_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnBoardScreen1 extends StatelessWidget {
  const OnBoardScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex = 0.obs;
    return Scaffold(
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getVerticalSpace(10.4.h),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                  height: 30.h,
                  width: selectedIndex.value == 1
                      ? MediaQuery.of(context).size.width
                      : 36.5.h,
                  child: Image(
                      image: selectedIndex.value == 1
                          ? const AssetImage('assets/pngs/onboardtwo.png')
                          : selectedIndex.value == 2
                              ? const AssetImage('assets/pngs/onboardthree.png')
                              : const AssetImage(
                                  'assets/pngs/onboradone.png'))),
            ),
            getVerticalSpace(7.8.h),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 2.4.h, vertical: 2.7.h),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.h),
                      topLeft: Radius.circular(5.h),
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: .8.h),
                          height: selectedIndex.value == 0 ? 1.h : .8.h,
                          width: selectedIndex.value == 0 ? 2.6.h : 1.2.h,
                          decoration: BoxDecoration(
                              color: selectedIndex.value == 0
                                  ? AppColors.primaryColor
                                  : AppColors.fullGrey,
                              borderRadius: BorderRadius.circular(10.h)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: .8.h),
                          height: selectedIndex.value == 1 ? 1.h : .8.h,
                          width: selectedIndex.value == 1 ? 2.6.h : 1.2.h,
                          decoration: BoxDecoration(
                              color: selectedIndex.value == 1
                                  ? AppColors.primaryColor
                                  : AppColors.fullGrey,
                              borderRadius: BorderRadius.circular(10.h)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: .8.h),
                          height: selectedIndex.value == 2 ? 1.h : .8.h,
                          width: selectedIndex.value == 2 ? 2.6.h : 1.2.h,
                          decoration: BoxDecoration(
                              color: selectedIndex.value == 2
                                  ? AppColors.primaryColor
                                  : AppColors.fullGrey,
                              borderRadius: BorderRadius.circular(10.h)),
                        ),
                      ],
                    ),
                    getVerticalSpace(4.h),
                    Text(
                      selectedIndex.value == 0
                          ? 'Welcome to My \nJournal'
                          : selectedIndex.value == 1
                              ? "Control \nYour Moods"
                              : "Define \nYour Goal",
                      style: AppTextStyles.boldStyle,
                      textAlign: TextAlign.center,
                    ),
                    getVerticalSpace(5.h),
                    Text(
                      selectedIndex.value == 0
                          ? 'Writing about my thoughts, feelings, and experiences as I reflect on them.'
                          : selectedIndex.value == 1
                              ? "Control your mood over time daily weekly,\nmonthly and all year around."
                              : "Create a clear, concise goal to stay motivated \nand focused on achieving success.",
                      style: AppTextStyles.regularStyle,
                      textAlign: TextAlign.center,
                    ),
                    getVerticalSpace(10.4.h),
                    selectedIndex.value == 2
                        ? customButton(
                            title: "Get Started",
                            onTap: () {
                              Get.offAll(() => const WelcomeScreen());
                            })
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    MySharedPreferences.setBool(
                                        'firstTime', true);
                                    Get.offAll(() => const WelcomeScreen());
                                  },
                                  child: Text(
                                    'Skip',
                                    style: AppTextStyles.simpleSmallText,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  MySharedPreferences.setBool(
                                      'firstTime', true);
                                  if (selectedIndex.value == 0) {
                                    selectedIndex.value = 1;
                                  } else if (selectedIndex.value == 1) {
                                    selectedIndex.value = 2;
                                  } else {
                                    selectedIndex.value = 0;
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(.8.h),
                                  height: 3.5.h,
                                  width: 4.5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.h),
                                      color: AppColors.deepBlack,
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.shadowColor,
                                            blurRadius: 8,
                                            spreadRadius: 0,
                                            offset: const Offset(0, 1))
                                      ]),
                                  child: SvgPicture.asset(
                                      'assets/svgs/aerrowicon.svg'),
                                ),
                              )
                            ],
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
