import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controllers/utils/app_colors.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  RxBool reminderSwitchValue = false.obs;
  RxBool darkMoodSwitchValue = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/pngs/background_image.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 10.5.h,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(3.h),
                bottomRight: Radius.circular(3.h),
              ),
              color: AppColors.blackColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(''),
                Text(
                  'Setting',
                  style: TextStyle(
                    fontSize: 16.px,
                    fontFamily: 'medium',
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'In-App Purchases',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.px,
                    fontFamily: 'Bold',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                getVerticalSpace(2.h),
                SettingRowWidget(
                  svg: 'assets/svgs/settings/app-purchase.svg',
                  title: 'Upgrade Premium',
                  onTap: () {},
                ),
                SettingRowWidget(
                  svg: 'assets/svgs/settings/restore.svg',
                  title: 'Restore Purchases',
                  onTap: () {},
                  unable: false,
                ),
                getVerticalSpace(3.h),
                Text(
                  'App Passcode',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.px,
                    fontFamily: 'Bold',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                getVerticalSpace(2.h),
                SettingRowWidget(
                  svg: 'assets/svgs/settings/face-id.svg',
                  title: 'Face ID',
                  onTap: () {},
                ),
                SettingRowWidget(
                  svg: 'assets/svgs/settings/set-passcode.svg',
                  title: 'Set Passcode',
                  onTap: () {},
                ),
                SettingRowWidget(
                  svg: 'assets/svgs/settings/disable-passcode.svg',
                  title: 'Disable Passcode',
                  onTap: () {},
                  unable: false,
                ),
                getVerticalSpace(7.h),
                Text(
                  'Daily Reminders',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.px,
                    fontFamily: 'Bold',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                getVerticalSpace(2.h),
                Row(
                  children: [
                    SvgPicture.asset('assets/svgs/settings/bell-icon.svg'),
                    getHorizentalSpace(4.px),
                    Text(
                      'Enable Reminders',
                      style: TextStyle(
                        fontSize: 12.px,
                        fontFamily: 'regular',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Obx(
                      () => SizedBox(
                        height: 10,
                        child: Transform.scale(
                          scale: 0.6,
                          child: CupertinoSwitch(
                            thumbColor: AppColors.blackColor,
                            onLabelColor: Colors.grey,
                            value: reminderSwitchValue.value,
                            onChanged: (value) {
                              reminderSwitchValue.value = value;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                getVerticalSpace(3.h),
                Text(
                  'Theme',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.px,
                    fontFamily: 'Bold',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                getVerticalSpace(2.h),
                Row(
                  children: [
                    SvgPicture.asset('assets/svgs/settings/dark-theme.svg'),
                    getHorizentalSpace(4.px),
                    Text(
                      'Dark mode',
                      style: TextStyle(
                        fontSize: 12.px,
                        fontFamily: 'regular',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Obx(
                      () => SizedBox(
                        height: 10,
                        child: Transform.scale(
                          scale: 0.6,
                          child: CupertinoSwitch(
                            thumbColor: AppColors.blackColor,
                            onLabelColor: Colors.grey,
                            value: darkMoodSwitchValue.value,
                            onChanged: (value) {
                              darkMoodSwitchValue.value = value;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingRowWidget extends StatelessWidget {
  final String svg;
  final String title;
  final VoidCallback onTap;
  final bool? unable;
  const SettingRowWidget(
      {super.key,
      required this.svg,
      required this.title,
      required this.onTap,
      this.unable = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(svg),
              getHorizentalSpace(4.px),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.px,
                  fontFamily: 'regular',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ],
          ),
          getVerticalSpace(4.px),
          unable == true
              ? Divider(
                  color: AppColors.blackColor,
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
