import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:my_journel/view/screens/checkin_screens/checkin_bar.dart';
import 'package:my_journel/view/screens/home_screen.dart';
import 'package:my_journel/view/screens/setting_screen.dart';
import 'package:my_journel/view/statistics_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/utils/app_colors.dart';
import 'goal_screen.dart';

class MyBottomBar extends StatefulWidget {
  MyBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int currentIndex = 0;

  late List<Widget> widgetOptions;

  @override
  void initState() {
    super.initState();
    widgetOptions = [
      HomeScreen(),
      StatisticsScreen(),
      GoalScreen(),
      SettingScreen(),
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
