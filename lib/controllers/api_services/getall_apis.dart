import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:my_journel/controllers/utils/constants.dart';
import 'package:my_journel/controllers/utils/shared_preferences.dart';
import '../../model/getallposts_model.dart';
import '../../model/goalsname_model.dart';
import '../../model/statistics_model.dart';
import 'base_url.dart';

class getAllPostsApis {
  final BuildContext context;
  getAllPostsApis(this.context);

  Future<GetAllPostsModel?> getAllPosts() async {
    final uri = Uri.parse(
        "${BaseUrl.url}/post/getByUserId/${MySharedPreferences.getString(userIdKey)}");
    final headers = {
      'Content-Type': 'application/json',
    };
    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      print("API Success: Get All Posts");
      print(response.body);
      return GetAllPostsModel.fromJson(jsonDecode(response.body));
    }
    print("API Failed: Get All Posts\n ${response.body}");
    return null;
  }

  Future<GoalHeadingModel?> getGoalHeading() async {
    final uri = Uri.parse("${BaseUrl.url}/headings/get/");
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      print("API Success: Get Goal Name");
      print(response.body);
      return GoalHeadingModel.fromJson(jsonDecode(response.body));
    }
    print("API Failed: Get Goal Name\n ${response.body}");
    return null;
  }

  Future<StatisticsModel?> getStatistics() async {
    final uri = Uri.parse(
        "${BaseUrl.url}/stats/getById/${MySharedPreferences.getString(userIdKey)}");
    // final headers = {
    //   'Content-Type': 'application/json',
    // };
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      print("API Success: Get All Statistics");
      print(response.body);
      return StatisticsModel.fromJson(jsonDecode(response.body));
    }
    print("API Failed: Get All Statistics\n ${response.body}");
    return null;
  }
}
