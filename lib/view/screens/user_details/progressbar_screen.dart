import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_journel/view/screens/user_details/pushor_notpush_screen.dart';
import 'package:my_journel/view/screens/user_details/select_gender_screen.dart';
import 'package:my_journel/view/screens/user_details/statement_below_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'age_screen.dart';
import 'daily_time_screen.dart';
import 'elevate_area_screen.dart';
import 'goals_screen.dart';
import 'motivation_screen.dart';

class ProgressBarScreen extends StatefulWidget {
  const ProgressBarScreen({super.key});

  @override
  _ProgressBarScreenState createState() => _ProgressBarScreenState();
}

class _ProgressBarScreenState extends State<ProgressBarScreen> {
  final ProgressBarScreenController progressBarScreenController =
      Get.put(ProgressBarScreenController());

  final List<Widget> screens = [
    SelectGenderScreen(),
    AgeScreen(),
    GoalsScreen(),
    ElevateAreaScreen(),
    DailyTimeScreen(),
    MotivationScreen(),
    PushOrNotPushScreen(),
    StatementBelowScreen(),
  ];

  @override
  void initState() {
    super.initState();
    progressBarScreenController.pageController.addListener(() {
      int newIndex = progressBarScreenController.pageController.page?.round() ??
          progressBarScreenController.currentIndex.value;
      if (newIndex != progressBarScreenController.currentIndex.value) {
        setState(() {
          progressBarScreenController.currentIndex.value = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    progressBarScreenController.pageController.dispose();
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
                      itemCount: progressBarScreenController.totalScreens.value,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            height: 5,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.px),
                              color: index <=
                                      progressBarScreenController
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
                  controller: progressBarScreenController.pageController,
                  itemCount: progressBarScreenController.totalScreens.value,
                  itemBuilder: (context, index) {
                    return screens[index];
                  },
                ),
              ),
              // Navigation Buttons
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       ElevatedButton(
              //         onPressed: progressBarScreenController.previousScreen,
              //         child: Text('Previous'),
              //       ),
              //       ElevatedButton(
              //         onPressed: progressBarScreenController.nextScreen,
              //         child: Text('Next'),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressBarScreenController extends GetxController {
  // observable variable where store the data of selected moods
  // Gender Screen
  RxString selectedGender = ''.obs;

  // Age Screen
  RxInt selectedIndex = 0.obs;
  RxString selectedAge = ''.obs;

  // Goals Screen
  final RxList<String> selectedGoals = <String>[].obs;

  // elevates
  RxList selectedAreaElevate = [].obs;

  // Growth Time Screen
  RxInt selectedTimeIndex = 0.obs;
  RxString growthTime = ''.obs;

  // Motivation Screen
  RxInt selectedMotivationIndex = 0.obs;
  RxString selectedMotivation = ''.obs;

  // staying on Track
  RxBool switchValue = false.obs;

  // Do you agree with statement below? Screen
  RxBool personalGrowth = false.obs;
  RxBool keepMovingForward = false.obs;

  RxInt currentIndex = 0.obs;
  final RxInt totalScreens = 8.obs;
  final PageController pageController = PageController();

  void nextScreen() {
    if (currentIndex.value < totalScreens.value - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousScreen() {
    if (currentIndex.value > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
