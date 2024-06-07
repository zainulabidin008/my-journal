import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controllers/utils/app_colors.dart';

class IntroductionWidget extends StatelessWidget {
  const IntroductionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 240,
            child: Container(
              height: 309,
              width: Get.width,
            ),
          ),
          Positioned(
            top: 275,
            left: 10,
            child: Container(
              height: 277,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.px),
                  topLeft: Radius.circular(16.px),
                  bottomLeft: Radius.circular(16.px),
                ),
                color: AppColors.whiteColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.h),
                child: Column(
                  children: [
                    getVerticalSpace(5.h),
                    Text(
                      "I'll help you navigate the ups and downs in life",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.px,
                        fontFamily: 'medium',
                        color: AppColors.deepBlack,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    getVerticalSpace(3.h),
                    Text(
                      "Mood check-ins allow you to track what you're doing and how you're feeling throughout the day.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: 'regular',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    getVerticalSpace(3.h),
                    Text(
                      "Click the add button below and select 'Mood check-in'. Then we can try it out together!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: 'regular',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 122,
            top: 240,
            child: Container(
              height: 64,
              width: 81,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.px),
                color: AppColors.whiteColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.px),
                child: SvgPicture.asset('assets/svgs/information-face.svg'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AnimatedContainerExample extends StatefulWidget {
  @override
  _AnimatedContainerExampleState createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation1 = Tween<double>(begin: 240.0, end: 260.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _animation2 = Tween<double>(begin: 275.0, end: 295.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation1,
            builder: (context, child) {
              return Positioned(
                top: _animation1.value,
                left: 122,
                child: Container(
                  height: 64,
                  width: 81,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('assets/svgs/information-face.svg'),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _animation2,
            builder: (context, child) {
              return Positioned(
                top: _animation2.value,
                left: 10,
                child: Container(
                  height: 277,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 16.0),
                        Text(
                          "I'll help you navigate the ups and downs in life",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'medium',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          "Mood check-ins allow you to track what you're doing and how you're feeling throughout the day.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'regular',
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          "Click the add button below and select 'Mood check-in'. Then we can try it out together!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'regular',
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 240,
            child: Container(
              height: 309,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
