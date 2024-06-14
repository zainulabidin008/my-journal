import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:my_journel/view/screens/checkin_screens/set_goals.dart';
import 'package:my_journel/view/screens/checkin_screens/whatbad_evenining_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'day_screen.dart';
import 'feel_about_screen.dart';
import 'goals_tomorrow.dart';

// class CheckInBar extends StatefulWidget {
//   @override
//   State<CheckInBar> createState() => _CheckInBarState();
// }
//
// class _CheckInBarState extends State<CheckInBar> {
//   final CheckInProgressBarController controller =
//       Get.find<CheckInProgressBarController>();
//
//   // @override
//   // void dispose() {
//   //   // TODO: implement dispose
//   //   super.dispose();
//   //   controller.pageController.dispose();
//   // }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller.currentIndex.value = 0;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('current page: ${controller.currentIndex.value}');
//
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
//               child: SizedBox(
//                 height: 6,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: controller.checkInTotalScreens.value,
//                   itemBuilder: (context, index) {
//                     print(
//                         'current page lvb: ${index <= controller.currentIndex.value}');
//                     return Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 4),
//                       child: Obx(
//                         () => Container(
//                           height: 5,
//                           width: 50,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(6.px),
//                             color: index <= controller.currentIndex.value
//                                 ? Colors.black
//                                 : Colors.white,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             Expanded(
//               child: PageView(
//                 controller: controller.pageController,
//                 onPageChanged: (index) {
//                   controller.currentIndex.value = index;
//                 },
//                 children: [
//                   DayScreen(),
//                   EveningBadScreen(),
//                   FeelAboutScreen(),
//                   SetGoalsScreen(),
//                   GoalsForTomorrowScreen(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CheckInProgressBarController extends GetxController {
//   RxInt currentIndex = 0.obs;
//   final RxInt checkInTotalScreens = 5.obs;
//   late PageController pageController;
//
//   CheckInProgressBarController() {
//     pageController = PageController();
//   }
//
//   void nextScreen() {
//     if (currentIndex.value < checkInTotalScreens.value - 1) {
//       pageController.nextPage(
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       pageController.dispose();
//     }
//   }
//
//   // @override
//   // void onClose() {
//   //   pageController.dispose();
//   //   super.onClose();
//   // }
// }

class CheckInBarController extends GetxController {
  RxString moodsId = ''.obs;

  var currentIndex = 0.obs;

  void nextScreen() {
    if (currentIndex < 4) {
      currentIndex++;
    }
  }

  void previousScreen() {
    if (currentIndex > 0) {
      currentIndex--;
    }
  }

  bool shouldFillDots(int index) {
    return currentIndex.value >= index;
  }

  @override
  void onClose() {
    super.onClose();
    // Clean up resources here if needed
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CheckInBarController controller = Get.put(CheckInBarController());

  final List<Widget> screens = [
    DayScreen(),
    EveningBadScreen(),
    FeelAboutScreen(),
    SetGoalsScreen(),
    GoalsForTomorrowScreen(),
  ];

  @override
  void dispose() {
    Get.delete<CheckInBarController>();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.currentIndex.value =
        0; // Reset to first screen on initialization
  }

  void navigateToScreen(int index) {
    controller.currentIndex.value = index;
    Get.to(() => screens[index], arguments: {'moodsId': controller.moodsId});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.delete<CheckInBarController>();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              getVerticalSpace(3.h),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () => navigateToScreen(index),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.px),
                              color: controller.shouldFillDots(index)
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                  )),
              Expanded(
                child: Obx(() => screens[controller.currentIndex.value]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
