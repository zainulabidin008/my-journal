import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/view/screens/user_details/progressbar_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../custom_widgets/ui_components.dart';

class SelectGenderScreen extends StatelessWidget {
  final ProgressBarScreenController progressBarScreenController =
      Get.put(ProgressBarScreenController());

  SelectGenderScreen({super.key});
  RxList gender = [
    'Male',
    'Female',
  ].obs;

  var selectedGender = ''.obs;

  void selectGender(String gender) {
    selectedGender.value = gender;
    print(gender);
  }

  RxInt selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 2.h),
      child: Column(
        children: [
          SizedBox(height: 2.h),
          SvgPicture.asset('assets/svgs/select-gender.svg'),
          SizedBox(height: 5.h),
          Text(
            'Select  Gender',
            style: AppTextStyles.heading,
          ),
          SizedBox(height: 4.px),
          Text(
            'Please select your gender',
            style: AppTextStyles.regularStyle,
          ),
          SizedBox(height: 4.h),
          // ListView.builder(
          //   itemBuilder: (context, index) {
          //     return Container(
          //       height: 140.px,
          //       width: 120.px,
          //       child: Column(
          //         children: [],
          //       ),
          //     );
          //   },
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Male Box
              GestureDetector(
                onTap: () {
                  selectGender('Male');
                },
                child: Obx(() {
                  return Container(
                    height: 140.px,
                    width: 120.px,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.px),
                      border: Border.all(
                          width: 2.px,
                          color: selectedGender.value == 'Male'
                              ? Colors.black
                              : Colors.white),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset('assets/svgs/male.svg'),
                        Text(
                          'Male',
                          // style: ,
                        ),
                      ],
                    ),
                  );
                }),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  selectGender('Female');
                },
                child: Obx(() {
                  return Container(
                    height: 140.px,
                    width: 120.px,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.px),
                      border: Border.all(
                          width: 2.px,
                          color: selectedGender.value == 'Female'
                              ? Colors.black
                              : Colors.white),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset('assets/svgs/female.svg'),
                        Text(
                          'Female',
                          // style: ,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
          Spacer(),
          CustomNextButton(
            title: 'Next',
            onTap: () {
              if (selectedGender.value.isEmpty) {
                customScaffoldMessenger(context, 'please select a gender');
              } else {
                progressBarScreenController.nextScreen();
              }
            },
          ),
        ],
      ),
    );
  }
}
