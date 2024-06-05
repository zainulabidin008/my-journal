import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_journel/view/bottombar.dart';
import 'package:my_journel/view/screens/buy_now_screen.dart';
import 'package:my_journel/view/screens/splash_screen.dart';
import 'package:my_journel/view/screens/user_details/progressbar_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'controllers/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(scaffoldBackgroundColor: AppColors.primaryColor),
          home: const SplashScreen(),
          // home: const ProgressBarScreen(),
          // home: ScreenManager(),
          // home: CaretakerBottomNavigationScreen(),
        );
      },
    );
  }
}
