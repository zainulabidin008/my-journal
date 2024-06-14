import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;

import '../../model/checkin_models/activities_model.dart';
import '../../model/checkin_models/feelings_model.dart';
import '../../model/checkin_models/moodes_model.dart';
import 'base_url.dart';

class CheckInApis {
  final BuildContext context;
  CheckInApis(this.context);

  Future<MoodsModel?> moodsApi() async {
    final uri = Uri.parse("${BaseUrl.url}/moods/getAll");
    final headers = {
      'Content-Type': 'application/json',
    };
    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      print("API Success: Get All Moods");
      print(response.body);
      return MoodsModel.fromJson(jsonDecode(response.body));
    }
    print("API Failed: Get All Moods\n ${response.body}");
    return null;
  }

  Future<ActivitiesModel?> activitiesApi() async {
    final uri = Uri.parse("${BaseUrl.url}/activities/getAll");
    final headers = {
      'Content-Type': 'application/json',
    };
    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      print("API Success: Get All Activities");
      print(response.body);
      return ActivitiesModel.fromJson(jsonDecode(response.body));
    }
    print("API Failed: Get All Activities\n ${response.body}");
    return null;
  }

  Future<FeelingsModel?> feelingsApi() async {
    final uri = Uri.parse("${BaseUrl.url}/feelings/getAll");
    final headers = {
      'Content-Type': 'application/json',
    };
    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      print("API Success: Get All Feelings");
      print(response.body);
      return FeelingsModel.fromJson(jsonDecode(response.body));
    }
    print("API Failed: Get All Feelings\n ${response.body}");
    return null;
  }
}
