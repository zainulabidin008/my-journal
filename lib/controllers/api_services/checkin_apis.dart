import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:my_journel/controllers/utils/local_storage_variables.dart';
import 'package:my_journel/controllers/utils/shared_preferences.dart';
import 'package:my_journel/view/bottombar.dart';
import '../../custom_widgets/ui_components.dart';
import '../../model/checkin_models/activities_model.dart';
import '../../model/checkin_models/feelings_model.dart';
import '../../model/checkin_models/moodes_model.dart';
import '../utils/constants.dart';
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

  Future<void> checkInStatusApi(
    // String userId,
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
      "userId": MySharedPreferences.getString(userIdKey),
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
      Get.offAll(() => MyBottomBar());
      log("checkInStatusApi create Successfully");
      customScaffoldMessenger(context, 'Otp Verified Successfully');
    } else {
      log("checkInStatusApi created failed");
      log(responseBody["message"]);
      customScaffoldMessenger(context, responseBody["message"]);
    }
  }

  Future<void> sendVoiceNote(
    File audioFile,
    String mood,
    List activities,
    List feelings,
    bool goalAchieve,
    String dayDescription,
    String tomorrowDescription,
  ) async {
    if (audioFile.path.isEmpty) return;

    var userId = MySharedPreferences.getString(userIdKey);
    if (userId == null || userId.isEmpty) {
      log('User ID not found');
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${BaseUrl.url}/note/create'),
    );
    request.fields['userId'] = userId;
    log("api audio path: ${audioFile.path}");
    request.files
        .add(await http.MultipartFile.fromPath('note', audioFile.path));

    var response = await request.send();
    String responseBody = await response.stream.bytesToString();
    var responseData = jsonDecode(responseBody);
    if (responseData['message'] != 'No Voice Note Found') {
      log('Voice note o successfully');
      log('body: $responseBody');
      String noteId = responseData['data']['_id'];
      // checkInStatusApi();
      checkInStatusApi(mood, activities, feelings, goalAchieve, dayDescription,
          noteId, tomorrowDescription);
      log("check Apis: $mood, $activities, $feelings, $goalAchieve, $dayDescription, $noteId, $tomorrowDescription");
    } else {
      log('No Voice Note Found');
    }
  }
}
