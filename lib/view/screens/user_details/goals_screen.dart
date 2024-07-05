import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/view/screens/user_details/progressbar_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/getx_controller/user_detail_controller.dart';
import '../../../custom_widgets/ui_components.dart';
import '../../../model/goals_model.dart';

class GoalsScreen extends StatelessWidget {
  final ProgressBarScreenController progressBarScreenController =
      Get.put(ProgressBarScreenController());
  final String imageBaseUrl = 'https://myjournalstorage.blob.core.windows.net/';
  GoalsScreen({super.key});

  // final RxList<String> svg = [
  //   'assets/svgs/close knit family.svg',
  //   'assets/svgs/achieve-life-balance.svg',
  //   'assets/svgs/successful career.svg',
  //   'assets/svgs/Become confident.svg',
  //   'assets/svgs/Increase Productivity.svg',
  //   'assets/svgs/Self employee.svg',
  // ].obs;
  //
  // final RxList<String> goals = [
  //   'Built a close-knit family',
  //   'Achieve life balance',
  //   'Have a successful career',
  //   'Become confident',
  //   'Increase Productivity',
  //   'Self employee',
  // ].obs;

  @override
  Widget build(BuildContext context) {
    final UserDetailController controller =
        Get.put(UserDetailController(context));
    controller.userDetails();
    return Scaffold(
      body: Obx(() {
        if (controller.loading.value) {
          return Center(
            child: LoadingAnimationWidget.prograssiveDots(
                color: AppColors.blackColor, size: 10.h),
          );
        }
        if (controller.temperatures.value == null) {
          return Center(
            child: Text("No data available"),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 2.h),
            child: Column(
              children: [
                SizedBox(height: 5.h),
                Text(
                  'What are your goals?',
                  style: AppTextStyles.heading,
                ),
                SizedBox(height: 4.px),
                Text(
                  textAlign: TextAlign.center,
                  'Choose up to 3 goals for more precise personalization',
                  style: AppTextStyles.regularStyle,
                ),
                SizedBox(height: 4.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.temperatures.value?.data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0, // Aspect ratio of each grid item
                  ),
                  itemBuilder: (context, index) {
                    print(
                        'Length: ${controller.temperatures.value?.data.length}');
                    Datum datum = controller.temperatures.value!.data[index];
                    return Obx(
                      () => GestureDetector(
                        onTap: () {
                          if (progressBarScreenController.selectedGoals
                              .contains(datum.id)) {
                            progressBarScreenController.selectedGoals
                                .remove(datum.id);
                          } else {
                            if (progressBarScreenController
                                    .selectedGoals.length <
                                3) {
                              progressBarScreenController.selectedGoals
                                  .add(datum.id);
                            }
                          }
                          print(progressBarScreenController.selectedGoals
                              .join(', '));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 12.h,
                              width: 17.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.px),
                                color: Colors.white,
                                border: Border.all(
                                  width: 2.px,
                                  color: progressBarScreenController
                                          .selectedGoals
                                          .contains(datum.id)
                                      ? Colors.black
                                      : Colors.transparent,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.px),
                                child: Image.network(
                                  '$imageBaseUrl${datum.image}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Expanded(
                              child: Text(
                                datum.title,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 2.h),
                CustomNextButton(
                  title: 'Next',
                  onTap: () {
                    if (progressBarScreenController.selectedGoals.isEmpty) {
                      customScaffoldMessenger(
                          context, 'please select minimum 1 goal');
                    } else if (progressBarScreenController
                        .selectedGoals.isNotEmpty) {
                      progressBarScreenController.nextScreen();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// class UserDetailScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final UserDetailController controller =
//         Get.put(UserDetailController(context));
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("User Details"),
//       ),
//       body: Obx(() {
//         if (controller.loading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.temperatures.value == null) {
//           return Center(child: Text("No data available"));
//         }
//
//         return ListView.builder(
//           itemCount: controller.temperatures.value?.data.length ?? 0,
//           itemBuilder: (context, index) {
//             Datum datum = controller.temperatures.value!.data[index];
//             return ListTile(
//               title: Text(datum.title),
//               subtitle: Text(datum.path),
//               leading: Image.network(datum.image),
//               trailing: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Created at: ${datum.createdAt.toLocal()}"),
//                   Text("Updated at: ${datum.updatedAt.toLocal()}"),
//                 ],
//               ),
//             );
//           },
//         );
//       }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           controller.userDetails();
//         },
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }
