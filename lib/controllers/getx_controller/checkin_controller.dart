import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/checkin_models/activities_model.dart';
import '../../model/checkin_models/feelings_model.dart';
import '../../model/checkin_models/moodes_model.dart';
import '../api_services/checkin_apis.dart';

class CheckInController extends GetxController {
  late final BuildContext context;
  CheckInController(this.context);

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
}
