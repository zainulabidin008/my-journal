import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controllers/utils/app_colors.dart';
import '../../controllers/utils/app_styles.dart';
import '../../custom_widgets/ui_components.dart';
import '../bottombar.dart';
import 'checkin_screens/checkin_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final RxList<HomeScreenModel> weekList = [
    HomeScreenModel(
        week: 'Mon', day: '01', svg: 'assets/svgs/home_screen/Frame 61.svg'),
    HomeScreenModel(
        week: 'Tue',
        day: '02',
        svg: 'assets/svgs/home_screen/Frame 61 (1).svg'),
    HomeScreenModel(
        week: 'Wed',
        day: '03',
        svg: 'assets/svgs/home_screen/Frame 61 (2).svg'),
    HomeScreenModel(
        week: 'Thur',
        day: '04',
        svg: 'assets/svgs/home_screen/Frame 61 (3).svg'),
    HomeScreenModel(
        week: 'Fri',
        day: '05',
        svg: 'assets/svgs/home_screen/Frame 61 (4).svg'),
  ].obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Fri,May 17',
                      style: TextStyle(
                        fontSize: 16.px,
                        fontFamily: 'regular',
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Hey Mohsin!',
                      style: TextStyle(
                        fontSize: 20.px,
                        fontFamily: 'Bold',
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              getVerticalSpace(2.h),
              SizedBox(
                height: 110,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final item = weekList[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.h),
                      child: Container(
                        height: 104,
                        // width: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.h),
                          color: AppColors.whiteColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.week,
                                style: AppTextStyles.subtitleGrey,
                              ),
                              Text(
                                item.day,
                                style: AppTextStyles.heading1,
                              ),
                              getVerticalSpace(1.h),
                              SvgPicture.asset(item.svg),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              getVerticalSpace(3.h),
              Expanded(
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32.px),
                      topLeft: Radius.circular(32.px),
                    ),
                    color: AppColors.primaryColor,
                  ),
                  child: Column(
                    children: [
                      getVerticalSpace(2.h),
                      Container(
                        height: 7,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.px),
                          color: Colors.white,
                        ),
                      ),
                      getVerticalSpace(8.h),
                      SvgPicture.asset('assets/svgs/home1.svg'),
                      Text(
                        'No records for today?',
                        style: TextStyle(
                          fontSize: 16.px,
                          fontFamily: 'medium',
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      getVerticalSpace(1.h),
                      Text(
                        textAlign: TextAlign.center,
                        'You don’t have any entries for today\nPress the Check In button to further continue',
                        style: TextStyle(
                          fontSize: 12.px,
                          fontFamily: 'regular',
                          color: AppColors.simpleSmallTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 70,
            right: 0,
            child: FloatingActionButton(
              backgroundColor: AppColors.blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {
                Get.to(() => CheckInBar());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.whiteColor,
                  ),
                  Text(
                    'Check in',
                    style: TextStyle(
                      fontSize: 10.px,
                      fontFamily: 'medium',
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
