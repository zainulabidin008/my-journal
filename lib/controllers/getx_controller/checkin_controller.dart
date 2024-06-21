import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/checkin_models/activities_model.dart';
import '../../model/checkin_models/feelings_model.dart';
import '../../model/checkin_models/moodes_model.dart';
import '../../view/screens/checkin_screens/checkin_bar.dart';
import '../api_services/checkin_apis.dart';
import '../utils/constants.dart';
import '../utils/local_storage_variables.dart';
import '../utils/shared_preferences.dart';

class CheckInController extends GetxController {
  late final BuildContext context;
  CheckInController(this.context);
  final CheckInBarController controller = Get.put(CheckInBarController());

  RxBool loading = false.obs;
  Rx<MoodsModel?> moods = Rx<MoodsModel?>(null);
  Rx<ActivitiesModel?> activities = Rx<ActivitiesModel?>(null);
  Rx<FeelingsModel?> feelings = Rx<FeelingsModel?>(null);

  Future<void> moodsDetails() async {
    try {
      loading.value = true;
      CheckInApis moodsDetail =
          CheckInApis(context); // Create an instance of UserDetail
      MoodsModel? fetchedTemperatures = await moodsDetail
          .moodsApi(); // Call the instance method on the instance
      if (fetchedTemperatures != null) {
        moods.value = fetchedTemperatures;
      }
    } catch (e) {
      print('Error during get Details: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> activitiesDetails() async {
    try {
      loading.value = true;
      CheckInApis activitie =
          CheckInApis(context); // Create an instance of UserDetail
      ActivitiesModel? fetchedTemperatures = await activitie
          .activitiesApi(); // Call the instance method on the instance
      if (fetchedTemperatures != null) {
        activities.value = fetchedTemperatures;
      }
    } catch (e) {
      print('Error during get Details: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> feelingsDetails() async {
    try {
      loading.value = true;
      CheckInApis feeling =
          CheckInApis(context); // Create an instance of UserDetail
      FeelingsModel? fetchedTemperatures = await feeling
          .feelingsApi(); // Call the instance method on the instance
      if (fetchedTemperatures != null) {
        feelings.value = fetchedTemperatures;
      }
    } catch (e) {
      print('Error during get Details: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> checkInStatus() async {
    try {
      loading.value = true;
      CheckInApis checkInApis =
          CheckInApis(context); // Create an instance of UserDetail

      checkInApis.checkInStatusApi(
          MySharedPreferences.getString(userIdKey),
          controller.moodsId.toString(),
          controller.activities,
          controller.selectedFeelings,
          controller.isYesSelected.value,
          controller.describeDayController.text,
          '667574efecb4b814ade69f50',
          controller.tomorrowGoalController.text);
    } catch (e) {
      print('Error during get Details: $e');
    } finally {
      loading.value = false;
    }
  }
}
