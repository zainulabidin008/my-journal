import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/api_services/user_details_apis.dart';
import '../../model/elevates_model.dart';
import '../../model/goals_model.dart';
import '../../model/motivation_model.dart';
import '../../view/screens/user_details/progressbar_screen.dart';

class UserDetailController extends GetxController {
  late final BuildContext context;
  UserDetailController(this.context);
  final ProgressBarScreenController progressBarScreenController =
      Get.put(ProgressBarScreenController());

  RxBool loading = false.obs;
  Rx<Temperatures?> temperatures = Rx<Temperatures?>(null);
  Rx<MotivationModel?> motivations = Rx<MotivationModel?>(null);
  Rx<ElevatesModel?> elevations = Rx<ElevatesModel?>(null);

  // goals Api
  Future<void> userDetails() async {
    try {
      loading.value = true;
      UserDetail userDetail =
          UserDetail(context); // Create an instance of UserDetail
      Temperatures? fetchedTemperatures = await userDetail
          .userGoals(); // Call the instance method on the instance
      if (fetchedTemperatures != null) {
        temperatures.value = fetchedTemperatures;
      }
    } catch (e) {
      print('Error during get Details: $e');
    } finally {
      loading.value = false;
    }
  }

  // motivation Api
  Future<void> motivation() async {
    loading.value = true;
    try {
      UserDetail userDetail = UserDetail(context);

      MotivationModel? fetchMotivation = await userDetail.motivationApi();
      if (fetchMotivation != null) {
        motivations.value = fetchMotivation;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during get Detail: $e');
      }
    } finally {
      loading.value = false;
    }
  }

  // elevate Api
  Future<void> elevate() async {
    loading.value = true;
    try {
      UserDetail userDetail = UserDetail(context);

      ElevatesModel? fetchElevate = await userDetail.elevatesApi();
      if (fetchElevate != null) {
        elevations.value = fetchElevate;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during get Detail: $e');
      }
    } finally {
      loading.value = false;
    }
  }

  Future<void> updateUser(
    String gender,
    String age,
    List goals,
    List elevates,
    String growthTime,
    String motivations,
    bool stayOnTrack,
    bool personalGrowth,
    bool movingForward,
  ) async {
    loading.value = true;

    try {
      UserDetail userDetail = UserDetail(context);
      userDetail.updateUserDetails(gender, age, goals, elevates, growthTime,
          motivations, stayOnTrack, personalGrowth, movingForward);
    } catch (e) {
      if (kDebugMode) {
        print('Error during update Detail: $e');
      }
    } finally {
      loading.value = false;
    }
  }
}
