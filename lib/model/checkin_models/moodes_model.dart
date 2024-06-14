// To parse this JSON data, do
//
//     final moodsModel = moodsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MoodsModel moodsModelFromJson(String str) =>
    MoodsModel.fromJson(json.decode(str));

String moodsModelToJson(MoodsModel data) => json.encode(data.toJson());

class MoodsModel {
  String message;
  bool result;
  List<Datum> data;

  MoodsModel({
    required this.message,
    required this.result,
    required this.data,
  });

  factory MoodsModel.fromJson(Map<String, dynamic> json) => MoodsModel(
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
