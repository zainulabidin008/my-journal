// To parse this JSON data, do
//
//     final elevatesModel = elevatesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ElevatesModel elevatesModelFromJson(String str) =>
    ElevatesModel.fromJson(json.decode(str));

String elevatesModelToJson(ElevatesModel data) => json.encode(data.toJson());

class ElevatesModel {
  String message;
  bool result;
  List<ElevatesData> data;

  ElevatesModel({
    required this.message,
    required this.result,
    required this.data,
  });

  factory ElevatesModel.fromJson(Map<String, dynamic> json) => ElevatesModel(
        message: json["message"],
        result: json["result"],
        data: List<ElevatesData>.from(
            json["data"].map((x) => ElevatesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ElevatesData {
  String id;
  String title;
  DateTime createdAt;
  DateTime updatedAt;

  ElevatesData({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ElevatesData.fromJson(Map<String, dynamic> json) => ElevatesData(
        id: json["_id"],
        title: json["title"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
