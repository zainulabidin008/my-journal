import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_journel/controllers/utils/constants.dart';
import 'package:my_journel/controllers/utils/shared_preferences.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:my_journel/view/bottombar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/elevates_model.dart';
import '../../model/goals_model.dart';
import '../../model/motivation_model.dart';
import '../../view/screens/auth_Screens/login_screen.dart';
import 'base_url.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class UserDetail {
  final BuildContext context;
  UserDetail(this.context);

  Future<Temperatures?> userGoals() async {
    final uri = Uri.parse("${BaseUrl.url}/goals/getAll");
    final headers = {
      'Content-Type': 'application/json',
    };
    http.Response response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      print("API Success: Get All Goals");
      print(response.body);
      return Temperatures.fromJson(jsonDecode(response.body));
    }
    print("API Failed: Get All Goals\n ${response.body}");
    return null;
  }

  Future<MotivationModel?> motivationApi() async {
    final uri = Uri.parse("${BaseUrl.url}/motivations/getAll");
    final headers = {
      'Content-Type': 'application/json',
    };
    http.Response response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      print("API Success: Get All Motivation");
      if (kDebugMode) {
        print(response.body);
      }
      return MotivationModel.fromJson(jsonDecode(response.body));
    }
    print("API Failed: Get All Motivation\n ${response.body}");
    return null;
  }

  Future<ElevatesModel?> elevatesApi() async {
    final uri = Uri.parse("${BaseUrl.url}/elevates/getAll");
    final headers = {
      'Content-Type': 'application/json',
    };
    http.Response response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("API Success: Get All Elevates");
      }
      if (kDebugMode) {
        print(response.body);
      }
      return ElevatesModel.fromJson(jsonDecode(response.body));
    }
    if (kDebugMode) {
      print("API Failed: Get All Elevates\n ${response.body}");
    }
    return null;
  }

  Future<void> updateUserDetails(
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
    final url = Uri.parse(
        '${BaseUrl.url}/user/updateById/${MySharedPreferences.getString(userIdKey)}');
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = json.encode({
      "gender": gender,
      "age": age,
      "goals": goals,
      "elevates": elevates,
      "growthTime": growthTime,
      "motivations": motivations,
      "stayOnTrack": stayOnTrack,
      "personalGrowth": personalGrowth,
      "movingForward": movingForward,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200 &&
          responseData['message'] == "Successfully, Update User") {
        // final prefs = await SharedPreferences.getInstance();
        MySharedPreferences.setBool('userData', true);
        Get.off(() => MyBottomBar());
        print('User details updated successfully');
        customScaffoldMessenger(context, "your Data is Updated");
      } else {
        print('Failed to update user details: ${responseData['message']}');
        customScaffoldMessenger(context, responseData['message']);
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }
}
