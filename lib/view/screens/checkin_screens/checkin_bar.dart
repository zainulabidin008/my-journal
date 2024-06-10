import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_journel/view/screens/checkin_screens/set_goals.dart';
import 'package:my_journel/view/screens/checkin_screens/whatbad_evenining_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'checkin_bar.dart';
import 'day_screen.dart';
import 'feel_about_screen.dart';
import 'goals_tomorrow.dart';

class CheckInBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CheckInProgressBarController controller =
        Get.find<CheckInProgressBarController>();
    print('current page: ${controller.currentIndex.value}');

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
              child: SizedBox(
                height: 6,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.checkInTotalScreens.value,
                  itemBuilder: (context, index) {
                    print('current page lvb: ${controller.currentIndex.value}');
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Obx(
                        () => Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.px),
                            color: index <= controller.currentIndex.value
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.currentIndex.value = index;
                },
                children: [
                  DayScreen(),
                  EveningBadScreen(),
                  FeelAboutScreen(),
                  SetGoalsScreen(),
                  GoalsForTomorrowScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckInProgressBarController extends GetxController {
  RxInt currentIndex = 0.obs;
  final RxInt checkInTotalScreens = 5.obs;
  late PageController pageController;

  CheckInProgressBarController() {
    pageController = PageController();
  }

  void nextScreen() {
    if (currentIndex.value < checkInTotalScreens.value - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      pageController.dispose();
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
