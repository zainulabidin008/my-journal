// To parse this JSON data, do
//
//     final activitiesModel = activitiesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ActivitiesModel activitiesModelFromJson(String str) =>
    ActivitiesModel.fromJson(json.decode(str));

String activitiesModelToJson(ActivitiesModel data) =>
    json.encode(data.toJson());

class ActivitiesModel {
  String message;
  bool result;
  List<Datum> data;

  ActivitiesModel({
    required this.message,
    required this.result,
    required this.data,
  });

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) =>
      ActivitiesModel(
        message: json["message"],
        result: json["result"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String title;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  String path;

  Datum({
    required this.id,
    required this.title,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.path,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
