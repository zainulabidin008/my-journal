import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/api_services/user_details_apis.dart';

import '../../model/goals_model.dart';
import '../../model/motivation_model.dart';

class UserDetailController extends GetxController {
  late final BuildContext context;
  UserDetailController(this.context);

  RxBool loading = false.obs;
  Rx<Temperatures?> temperatures = Rx<Temperatures?>(null);
  Rx<MotivationModel?> motivations = Rx<MotivationModel?>(null);

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
    loading.value = false;
    try {
      UserDetail userDetail = UserDetail(context);

      MotivationModel? fetchMotivation = await userDetail.motivationApi();
      if (fetchMotivation != null) {
        motivations.value = fetchMotivation;
      }
    } catch (e) {
      print('Error during get Detail: $e');
    } finally {
      loading.value = false;
    }
  }
}