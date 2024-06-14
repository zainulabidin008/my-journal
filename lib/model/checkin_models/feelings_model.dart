// To parse this JSON data, do
//
//     final feelingsModel = feelingsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FeelingsModel feelingsModelFromJson(String str) =>
    FeelingsModel.fromJson(json.decode(str));

String feelingsModelToJson(FeelingsModel data) => json.encode(data.toJson());

class FeelingsModel {
  String message;
  bool result;
  List<FeelingsDatum> data;

  FeelingsModel({
    required this.message,
    required this.result,
    required this.data,
  });

  factory FeelingsModel.fromJson(Map<String, dynamic> json) => FeelingsModel(
        message: json["message"],
        result: json["result"],
        data: List<FeelingsDatum>.from(
            json["data"].map((x) => FeelingsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FeelingsDatum {
  String id;
  String title;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  String path;

  FeelingsDatum({
    required this.id,
    required this.title,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.path,
  });

  factory FeelingsDatum.fromJson(Map<String, dynamic> json) => FeelingsDatum(
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
