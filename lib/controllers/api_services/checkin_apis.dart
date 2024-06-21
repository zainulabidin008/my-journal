import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:my_journel/view/bottombar.dart';
import '../../custom_widgets/ui_components.dart';
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

  Future<String?> voiceNoteApi(File voiceNote, String id) async {
    final url = Uri.parse("${BaseUrl.url}/note/create");

    try {
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          'Content-Type': 'multipart/form-data',
        })
        ..fields['id'] = id;

      final file = await http.MultipartFile.fromPath('note', voiceNote.path);

      request.files.add(file);

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(responseBody);

        customScaffoldMessenger(context, decodedResponse['message']);
        if (decodedResponse['success']) {
          return decodedResponse['data']['url'];
        }
      } else {
        return null;
      }
    } catch (error) {
      if (context.mounted) {
        customScaffoldMessenger(
            context, 'An error occurred. Please try again.');
      }
      return null;
    }
    return null;
  }

  Future<void> checkInStatusApi(
    String userId,
    String mood,
    List activities,
    List feelings,
    bool goalAchieve, // Change RxBool to bool
    String dayDescription,
    String note,
    String tomorrowDescription,
  ) async {
    final url = Uri.parse("${BaseUrl.url}/post/create");
    final headers = {"Content-Type": "application/json"};
    print("User Id$userId");
    final body = jsonEncode({
      "userId": userId,
      "mood": mood,
      "activities": activities,
      "feelings": feelings,
      "goalAchieve": goalAchieve,
      "dayDescription": dayDescription,
      "note": note,
      "tomorrowDescription": tomorrowDescription,
    });

    http.Response response = await http.post(url, headers: headers, body: body);
    final responseBody = jsonDecode(response.body);
    if (responseBody["result"] == true) {
      Get.off(() => MyBottomBar());
      log("checkInStatusApi create Successfully");
      customScaffoldMessenger(context, 'Otp Verified Successfully');
    } else {
      log("checkInStatusApi created failed");
      log(responseBody["message"]);
      customScaffoldMessenger(context, responseBody["message"]);
    }
  }
}
