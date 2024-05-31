import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../bottombar.dart';

class BuyNowScreen extends StatelessWidget {
  BuyNowScreen({super.key});
  final RxList<PersonalGrowthModel> personalGrowthList = [
    PersonalGrowthModel(number: '1', selectMonth: 'Year', chf: 'CHF 99.00'),
    PersonalGrowthModel(
        number: '1', selectMonth: 'Month', chf: 'CHF 12.00', of: 'CHF 24.00'),
    PersonalGrowthModel(number: '7', selectMonth: 'Days', chf: 'CHF 3.00'),
    // Add more instances as needed
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.h),
          child: Column(
            children: [
              SvgPicture.asset('assets/svgs/choose-plan.svg'),
              getVerticalSpace(3.h),
              Text(
                'CHOOSE PLAN',
                style: AppTextStyles.heading1,
              ),
              getVerticalSpace(3.h),
              choosePlanCustomWidget(
                  'assets/svgs/check-mark.svg', 'Learn what impacts your mood'),
              choosePlanCustomWidget(
                  'assets/svgs/check-mark.svg', 'Build a positive mindset'),
              choosePlanCustomWidget(
                  'assets/svgs/check-mark.svg', 'Become a Member'),
              choosePlanCustomWidget(
                  'assets/svgs/check-mark.svg', 'Set Goals and achieve them'),
              getVerticalSpace(5.h),
              Text(
                'CHOOSE PLAN',
                style: AppTextStyles.heading1,
              ),
              getVerticalSpace(3.h),
              Container(
                height: 29.px,
                width: 12.5.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.px),
                  color: AppColors.blackColor,
                ),
                child: Center(
                  child: Text(
                    'Best Value',
                    style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'regular',
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              getVerticalSpace(2.h),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final item = personalGrowthList[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.px),
                      child: Container(
                        height: 118,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.px),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(item.number, style: AppTextStyles.heading1),
                              getVerticalSpace(1.5.h),
                              Text(
                                item.selectMonth,
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'medium',
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              getVerticalSpace(1.h),
                              Text(
                                item.of ?? '',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12.px,
                                  fontFamily: 'regular',
                                  color: AppColors.simpleSmallTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                item.chf,
                                style: TextStyle(
                                  fontSize: 12.px,
                                  fontFamily: 'regular',
                                  color: item.of == null
                                      ? AppColors.simpleSmallTextColor
                                      : Color(0xff00B42C),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              getVerticalSpace(2.5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Trial period: ',
                    style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: 'regular',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '30 days ',
                    style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: 'Bold',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'for ',
                    style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: 'regular',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Free',
                    style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: 'Bold',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Spacer(),
              CustomNextButton(
                title: 'Buy Now',
                onTap: () {
                  Get.to(CaretakerBottomNavigationScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalGrowthModel {
  final String number;
  final String selectMonth;
  final String chf;
  final String? of;

  PersonalGrowthModel(
      {required this.number,
      required this.selectMonth,
      required this.chf,
      this.of});
}
