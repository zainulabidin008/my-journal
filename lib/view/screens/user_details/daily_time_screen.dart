import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_journel/view/screens/user_details/progressbar_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../custom_widgets/ui_components.dart';

class DailyTimeScreen extends StatefulWidget {
  DailyTimeScreen({super.key});

  @override
  State<DailyTimeScreen> createState() => _DailyTimeScreenState();
}

class _DailyTimeScreenState extends State<DailyTimeScreen> {
  final ProgressBarScreenController progressBarScreenController =
      Get.put(ProgressBarScreenController());

  var selectedIndex = 0.obs;

  void selectIndex(int index) {
    selectedIndex.value = index;
  }

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    double centerOffset =
        _scrollController.offset + 58; // Half of 116 (item height)
    int middleIndex = (centerOffset / 40).round();

    print("Center Offset: $centerOffset");
    print("Middle Index: $middleIndex");

    // Update the selected index
    selectIndex(middleIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 2.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5.h),
            Text(
              'How much time would you like to spend on growth daily?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold), // Replace with your text style
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 116,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: 30,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  int time = index + 1;
                  return GestureDetector(
                    onTap: () {
                      selectIndex(index);
                      _scrollController.animateTo(
                        index * 116.0, // Scroll to the selected item
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Obx(() {
                      return Container(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$time',
                              style: TextStyle(
                                fontSize:
                                    selectedIndex.value == index ? 20 : 16,
                                color: selectedIndex.value == index
                                    ? Colors.black
                                    : Color(0xff7C7C7C),
                                fontWeight: selectedIndex.value == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            SizedBox(width: 20),
                            selectedIndex.value == index
                                ? Text(
                                    'min',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    '         ',
                                  ),
                          ],
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
            Spacer(),
            CustomNextButton(
              title: 'Next',
              onTap: () {
                progressBarScreenController.nextScreen();
              },
            ),
          ],
        ),
      ),
    );
  }
}
