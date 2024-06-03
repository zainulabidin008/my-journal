import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/utils/app_colors.dart';

Widget getVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget getHorizentalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget customButton(
    {String? title,
    double? horizentalPadding,
    double? verticalPadding,
    Callback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 5.h,
      padding: EdgeInsets.symmetric(
          horizontal: horizentalPadding ?? 15.8.h,
          vertical: verticalPadding ?? 1.1.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.h,
          ),
          color: AppColors.deepBlack,
          boxShadow: [
            BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 8,
                spreadRadius: 0,
                offset: const Offset(0, 1))
          ]),
      child: Text(
        title!,
        style: AppTextStyles.buttonTextStyle,
      ),
    ),
  );
}

Widget customTextFormField(
  TextEditingController? controller,
  String? hintText, {
  TextInputType? keyboardType,
  Widget? prefixIcon,
  Widget? svg,
  ValueChanged<String>? onChanged,
  Icon? icon,
  Widget? suffixIcon,
  Color? iconColor,
  String? labelText,
  TextStyle? labelStyle,
  required bool isObscure,
  EdgeInsetsDirectional? contentPadding,
  Color? hintTextColor,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 1.2.h),
    alignment: Alignment.centerLeft,
    height: 5.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50.px),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          offset: const Offset(0, 2),
          spreadRadius: 2,
          blurRadius: 2,
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 26.px, // Set desired width
          height: 26.px, // Set desired height
          alignment: Alignment.center,
          child: Transform.scale(
            scale: 1, // Adjust the scale as needed
            child: prefixIcon,
          ),
        ),
        getHorizentalSpace(.4.h),
        Container(
          width: 6.px, // Set desired width
          height: 26.px, // Set desired height
          alignment: Alignment.center,
          child: Transform.scale(
            scale: 1, // Adjust the scale as needed
            child: svg,
          ),
        ),
        getHorizentalSpace(.4.h),
        Expanded(
          child: TextFormField(
            onChanged: onChanged,
            cursorHeight: 2.h,
            obscureText: isObscure,
            controller: controller,
            style: TextStyle(fontSize: 12.px, color: Colors.black),
            cursorColor:
                Colors.black, // Assuming AppColors.primaryColor is blue
            textAlign: TextAlign.left,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding:
                  contentPadding ?? EdgeInsets.symmetric(vertical: 1.5.h),
              isCollapsed: true,
              border: InputBorder.none,
              fillColor: Colors.white,
              suffixIcon: Container(
                width: 6.px, // Set desired width
                height: 26.px, // Set desired height
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: 1, // Adjust the scale as needed
                  child: suffixIcon,
                ),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                  color: hintTextColor ?? Colors.grey, fontSize: 12.px),
              labelText: labelText,
              labelStyle: labelStyle,
            ),
          ),
        ),
      ],
    ),
  );
}

class CustomNextButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CustomNextButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.px,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.h),
          color: AppColors.deepBlack,
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.buttonTextStyle,
          ),
        ),
      ),
    );
  }
}

customScaffoldMessenger(
  BuildContext context,
  String text,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(
          fontFamily: 'medium',
          fontSize: 14.sp,
        ),
      ),
      backgroundColor: AppColors.deepBlack,
      duration: const Duration(seconds: 2),
    ),
  );
}

choosePlanCustomWidget(
  String svg,
  String title,
) {
  return Row(
    children: [
      SvgPicture.asset(svg),
      getHorizentalSpace(5.px),
      Text(
        title,
        style: TextStyle(
          fontSize: 16.px,
          fontFamily: 'regular',
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor,
        ),
      ),
    ],
  );
}
