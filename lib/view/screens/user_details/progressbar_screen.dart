import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_journel/view/screens/user_details/select_gender_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'age_screen.dart';
import 'goals_screen.dart';

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
    Screen4(),
    Screen5(),
    Screen6(),
    Screen7(),
    Screen8(),
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

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Screen 2',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Screen 3',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Screen 4',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Screen 5',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class Screen6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Screen 6',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class Screen7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Screen 7',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class Screen8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Screen 8',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
