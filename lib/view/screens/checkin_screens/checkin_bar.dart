import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:my_journel/view/screens/checkin_screens/set_goals.dart';
import 'package:my_journel/view/screens/checkin_screens/whatbad_evenining_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'day_screen.dart';
import 'feel_about_screen.dart';
import 'goals_tomorrow.dart';

class CheckInBarController extends GetxController {
  final TextEditingController describeDayController = TextEditingController();
  final TextEditingController tomorrowGoalController = TextEditingController();
  RxString moodsId = ''.obs;
  RxList activities = [].obs;
  RxList selectedFeelings = [].obs;
  RxString audioPath = ''.obs;

  RxBool isYesSelected = false.obs;

  void selectYes() {
    isYesSelected.value = true;
  }

  void selectNo() {
    isYesSelected.value = false;
  }

  var currentIndex = 0.obs;

  void nextScreen() {
    if (currentIndex.value < 4) {
      currentIndex.value++;
    }
  }

  void previousScreen() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
  }

  bool shouldFillDots(int index) {
    return currentIndex.value >= index;
  }

  @override
  void onClose() {
    super.onClose();
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
    controller.currentIndex.value = 0;
  }

  void navigateToScreen(int index) {
    controller.currentIndex.value = index;
    Get.to(
      () => screens[index],
    );
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
              SizedBox(height: 3.h),
              Obx(
                () => Row(
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
                ),
              ),
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

// class ScreenOne extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Retrieve the data from the arguments
//     final moodsId = Get.arguments?['moodsId'] ?? 'No ID';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Day Screen'),
//       ),
//       body: Center(
//         child: Text('Moods ID: $moodsId'),
//       ),
//     );
//   }
// }
//
// class ScreenTwo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final moodsId = Get.arguments?['moodsId'] ?? 'No ID';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Evening Bad Screen'),
//       ),
//       body: Center(
//         child: Text('Moods ID: $moodsId'),
//       ),
//     );
//   }
// }
//
// class ScreenThree extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final moodsId = Get.arguments?['moodsId'] ?? 'No ID';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Feel About Screen'),
//       ),
//       body: Center(
//         child: Text('Moods ID: $moodsId'),
//       ),
//     );
//   }
// }
//
// class ScreenFour extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final moodsId = Get.arguments?['moodsId'] ?? 'No ID';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Goals For Tomorrow Screen'),
//       ),
//       body: Center(
//         child: Text('Moods ID: $moodsId'),
//       ),
//     );
//   }
// }
//
// class ScreenFive extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final moodsId = Get.arguments?['moodsId'] ?? 'No ID';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Set Goals Screen'),
//       ),
//       body: Center(
//         child: Text('Moods ID: $moodsId'),
//       ),
//     );
//   }
// }
