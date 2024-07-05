import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Simplified the imports for GetX
import 'package:my_journel/view/bottombar.dart';
import 'package:my_journel/view/screens/auth_Screens/login_screen.dart';
import 'package:my_journel/view/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/utils/shared_preferences.dart';
import 'onboarding_screens/onBoard_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      nextScreen();
    });
  }

  void nextScreen() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userIdKey');

    bool isFirstTime = MySharedPreferences.getBool('firstTime') ?? true;

    if (userId != null && userId.isNotEmpty) {
      Get.offAll(() => MyBottomBar());
    } else if (isFirstTime) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const OnBoardScreen1());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset('assets/svgs/myjournal.svg'),
      ),
    );
  }
}
