import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../user_details/progressbar_screen.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isVisible = false.obs;
    RxBool isVisible1 = false.obs;
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    return Scaffold(
      body: Obx(
        () => Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getVerticalSpace(12.5.h),
              Text(
                'Create a new password',
                style: AppTextStyles.boldStyle
                    .copyWith(fontSize: 20.px, color: const Color(0xff000000)),
              ),
              getVerticalSpace(1.6.h),
              Text(
                "Your new password must be different from\n previous used passwords.",
                style: AppTextStyles.simpleSmallText.copyWith(
                  fontSize: 14.px,
                  color: const Color(0xff2D3748),
                ),
                textAlign: TextAlign.center,
              ),
              getVerticalSpace(4.2.h),
              customTextFormField(
                oldPasswordController,
                'Password',
                prefixIcon: SvgPicture.asset('assets/svgs/passwordicon.svg'),
                isObscure: isVisible1.value == true ? false : true,
                svg: SvgPicture.asset('assets/svgs/lineicon.svg'),
                suffixIcon: GestureDetector(
                    onTap: () {
                      if (isVisible1.value == false) {
                        isVisible1.value = true;
                      } else {
                        isVisible1.value = false;
                      }
                    },
                    child: SvgPicture.asset(
                        isVisible1.value == false
                            ? 'assets/svgs/notvisible.svg'
                            : "assets/svgs/visible.svg",
                        colorFilter: const ColorFilter.mode(
                            Color(0xff9E9FA1), BlendMode.srcIn))),
              ),
              getVerticalSpace(1.2.h),
              customTextFormField(
                newPasswordController,
                'Confirm Password',
                prefixIcon: SvgPicture.asset('assets/svgs/passwordicon.svg'),
                isObscure: isVisible.value == true ? false : true,
                svg: SvgPicture.asset('assets/svgs/lineicon.svg'),
                suffixIcon: GestureDetector(
                    onTap: () {
                      if (isVisible.value == false) {
                        isVisible.value = true;
                      } else {
                        isVisible.value = false;
                      }
                    },
                    child: SvgPicture.asset(
                      isVisible.value == false
                          ? 'assets/svgs/notvisible.svg'
                          : "assets/svgs/visible.svg",
                      colorFilter: const ColorFilter.mode(
                          Color(0xff9E9FA1), BlendMode.srcIn),
                    )),
              ),
              getVerticalSpace(5.1.h),
              customButton(
                  horizentalPadding: 7.7.h,
                  verticalPadding: .8.h,
                  title: "Save",
                  onTap: () {
                    Get.to(() => const ProgressBarScreen());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
