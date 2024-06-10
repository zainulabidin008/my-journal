// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

import 'dart:convert';

MotivationModel temperaturesFromJson(String str) =>
    MotivationModel.fromJson(json.decode(str));

String temperaturesToJson(MotivationModel data) => json.encode(data.toJson());

class MotivationModel {
  String message;
  bool result;
  List<MotivationData> data;

  MotivationModel({
    required this.message,
    required this.result,
    required this.data,
  });

  factory MotivationModel.fromJson(Map<String, dynamic> json) =>
      MotivationModel(
        message: json["message"],
        result: json["result"],
        data: List<MotivationData>.from(
            json["data"].map((x) => MotivationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MotivationData {
  String id;
  String title;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  String path;

  MotivationData({
    required this.id,
    required this.title,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.path,
  });

  factory MotivationData.fromJson(Map<String, dynamic> json) => MotivationData(
        id: json["_id"],
        title: json["title"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "path": path,
      };
}
