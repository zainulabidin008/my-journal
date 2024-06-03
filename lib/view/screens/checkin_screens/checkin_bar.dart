import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_journel/view/screens/checkin_screens/set_goals.dart';
import 'package:my_journel/view/screens/checkin_screens/whatbad_evenining_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../user_details/age_screen.dart';
import '../user_details/daily_time_screen.dart';
import '../user_details/elevate_area_screen.dart';
import '../user_details/goals_screen.dart';
import '../user_details/progressbar_screen.dart';
import 'day_screen.dart';
import 'feel_about_screen.dart';
import 'goals_tomorrow.dart';

class CheckInBar extends StatefulWidget {
  const CheckInBar({super.key});

  @override
  _CheckInBarState createState() => _CheckInBarState();
}

class _CheckInBarState extends State<CheckInBar> {
  final CheckInProgressBarScreenController checkInProgressBarScreenController =
      Get.put(CheckInProgressBarScreenController());
  // final RxInt totalScreens = 5.obs;

  final List<Widget> screens = [
    DayScreen(),
    EveningBadScreen(),
    FeelAboutScreen(),
    SetGoalsScreen(),
    GoalsForTomorrowScreen(),
  ];

  @override
  void initState() {
    super.initState();
    checkInProgressBarScreenController.pageController.addListener(() {
      int newIndex =
          checkInProgressBarScreenController.pageController.page?.round() ??
              checkInProgressBarScreenController.currentIndex.value;
      if (newIndex != checkInProgressBarScreenController.currentIndex.value) {
        setState(() {
          checkInProgressBarScreenController.currentIndex.value = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    checkInProgressBarScreenController.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                child: SizedBox(
                  height: 6,
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: checkInProgressBarScreenController
                          .checkInTotalScreens.value,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.px),
                              color: index <=
                                      checkInProgressBarScreenController
                                          .currentIndex.value
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: checkInProgressBarScreenController.pageController,
                  itemCount: checkInProgressBarScreenController
                      .checkInTotalScreens.value,
                  itemBuilder: (context, index) {
                    return screens[index];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckInProgressBarScreenController extends GetxController {
  RxInt currentIndex = 0.obs;
  final RxInt checkInTotalScreens = 5.obs;
  final PageController pageController = PageController();

  void nextScreen() {
    if (currentIndex.value < checkInTotalScreens.value - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
