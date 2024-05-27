import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle boldStyle = TextStyle(
      fontSize: 32.px, fontFamily: 'Bold', color: AppColors.blackColor);

  static TextStyle regularStyle = TextStyle(
      fontSize: 16.px,
      fontFamily: 'regular',
      color: AppColors.regularTextColor);

  static TextStyle simpleSmallText = TextStyle(
      fontSize: 14.px,
      fontFamily: 'regular',
      color: AppColors.simpleSmallTextColor);

  static TextStyle heading = TextStyle(
    fontSize: 16.px,
    fontWeight: FontWeight.w600,
    fontFamily: 'Bold',
    color: AppColors.deepBlack,
  );

  static TextStyle buttonTextStyle = TextStyle(
      fontSize: 14.px, fontFamily: 'regular', color: AppColors.whiteColor);
}
