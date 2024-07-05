import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/getallposts_model.dart';
import '../../model/goalsname_model.dart';
import '../../model/statistics_model.dart';
import '../api_services/getall_apis.dart';

class GetAllApis extends GetxController {
  late final BuildContext context;
  GetAllApis(this.context);

  RxBool loading = false.obs;
  Rx<GetAllPostsModel?> getAllPost = Rx<GetAllPostsModel?>(null);
  Rx<GoalHeadingModel?> getGoalsHeading = Rx<GoalHeadingModel?>(null);
  Rx<StatisticsModel?> statistics = Rx<StatisticsModel?>(null);

  Future<void> getAllPosts() async {
    try {
      loading.value = true;
      getAllPostsApis getAllPosts =
          getAllPostsApis(context); // Create an instance of UserDetail
      GetAllPostsModel? fetchedTemperatures = await getAllPosts
          .getAllPosts(); // Call the instance method on the instance
      if (fetchedTemperatures != null) {
        getAllPost.value = fetchedTemperatures;
      }
    } catch (e) {
      print('Error during get All Posts: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> getHeading() async {
    try {
      loading.value = true;
      getAllPostsApis getAllPosts = getAllPostsApis(context);
      GoalHeadingModel? fetchedTemperatures =
          await getAllPosts.getGoalHeading();
      if (fetchedTemperatures != null) {
        getGoalsHeading.value = fetchedTemperatures;
      }
    } catch (e) {
      print('Error during get Details: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> getStatisticsData() async {
    try {
      loading.value = true;
      getAllPostsApis getAllPosts = getAllPostsApis(context);
      StatisticsModel? fetchedTemperatures = await getAllPosts.getStatistics();
      if (fetchedTemperatures != null) {
        statistics.value = fetchedTemperatures;
      }
    } catch (e) {
      print('Error during get Statistics: $e');
    } finally {
      loading.value = false;
    }
  }
}
