import 'dart:convert';
import 'package:flutter/material.dart';
import '../../model/elevates_model.dart';
import '../../model/goals_model.dart';
import '../../model/motivation_model.dart';
import 'base_url.dart';
import 'package:http/http.dart';

class UserDetail {
  final BuildContext context;
  UserDetail(this.context);

  Future<Temperatures?> userGoals() async {
    final uri = Uri.parse("${BaseUrl.url}/goals/getAll");
    final headers = {
      'Content-Type': 'application/json',
    };
    Response response = await get(uri, headers: headers);
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
    Response response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      print("API Success: Get All Motivation");
      print(response.body);
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
    Response response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      print("API Success: Get All Elevates");
      print(response.body);
      return ElevatesModel.fromJson(jsonDecode(response.body));
    }
    print("API Failed: Get All Elevates\n ${response.body}");
    return null;
  }
}
