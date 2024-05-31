import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:my_journel/view/screens/checkin_screens/checkin_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/utils/app_colors.dart';

class CaretakerBottomNavigationScreen extends StatefulWidget {
  CaretakerBottomNavigationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CaretakerBottomNavigationScreen> createState() =>
      _CaretakerBottomNavigationScreenState();
}

class _CaretakerBottomNavigationScreenState
    extends State<CaretakerBottomNavigationScreen> {
  int currentIndex = 0;

  late List<Widget> widgetOptions;

  @override
  void initState() {
    super.initState();
    widgetOptions = [
      HomeScreen(),
      SearchScreen(),
      NotificationsScreen(),
      ProfileScreen(),
    ];
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          widgetOptions.elementAt(currentIndex),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CurvedNavigationBar(
                height: 9.h,
                color: AppColors.blackColor,
                backgroundColor: Colors.transparent,
                buttonBackgroundColor: AppColors.blackColor,
                animationCurve: Curves.linear,
                animationDuration: const Duration(milliseconds: 300),
                index: currentIndex,
                items: [
                  SvgPicture.asset("assets/svgs/home.svg",
                      color: currentIndex == 0 ? Colors.white : Colors.white70,
                      height: 3.h,
                      width: 3.h),
                  SvgPicture.asset("assets/svgs/statistics.svg",
                      color: currentIndex == 1 ? Colors.white : Colors.white70,
                      height: 3.h,
                      width: 3.h),
                  SvgPicture.asset("assets/svgs/goal.svg",
                      color: currentIndex == 2 ? Colors.white : Colors.white70,
                      height: 3.h,
                      width: 3.h),
                  SvgPicture.asset("assets/svgs/settings.svg",
                      color: currentIndex == 3 ? Colors.white : Colors.white70,
                      height: 3.h,
                      width: 3.h),
                ],
                onTap: (index) => onTap(index),
              ),
              Positioned(
                bottom: 0.5.h,
                left: 0,
                right: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: currentIndex == 0 ? 'medium' : 'regular',
                        color: currentIndex == 0
                            ? AppColors.whiteColor
                            : AppColors.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Statistics",
                      style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: currentIndex == 1 ? 'medium' : 'regular',
                        color: currentIndex == 1
                            ? AppColors.whiteColor
                            : AppColors.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Goal  ",
                      style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: currentIndex == 2 ? 'medium' : 'regular',
                        color: currentIndex == 2
                            ? AppColors.whiteColor
                            : AppColors.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Setting",
                      style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: currentIndex == 3 ? 'medium' : 'regular',
                        color: currentIndex == 3
                            ? AppColors.whiteColor
                            : AppColors.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

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

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Screen'),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notifications Screen'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Screen'),
    );
  }
}

class HomeScreenModel {
  final String week;
  final String day;
  final String svg;

  HomeScreenModel({
    required this.week,
    required this.day,
    required this.svg,
  });
}
