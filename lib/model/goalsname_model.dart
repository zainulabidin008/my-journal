// To parse this JSON data, do
//
//     final goalHeadingModel = goalHeadingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GoalHeadingModel goalHeadingModelFromJson(String str) =>
    GoalHeadingModel.fromJson(json.decode(str));

String goalHeadingModelToJson(GoalHeadingModel data) =>
    json.encode(data.toJson());

class GoalHeadingModel {
  String message;
  bool result;
  Data data;

  GoalHeadingModel({
    required this.message,
    required this.result,
    required this.data,
  });

  factory GoalHeadingModel.fromJson(Map<String, dynamic> json) =>
      GoalHeadingModel(
        message: json["message"],
        result: json["result"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result,
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String goal;
  String elevate;
  String motivation;
  String activity;
  String feeling;
  String mood;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.goal,
    required this.elevate,
    required this.motivation,
    required this.activity,
    required this.feeling,
    required this.mood,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        goal: json["goal"],
        elevate: json["elevate"],
        motivation: json["motivation"],
        activity: json["activity"],
        feeling: json["feeling"],
        mood: json["mood"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "goal": goal,
        "elevate": elevate,
        "motivation": motivation,
        "activity": activity,
        "feeling": feeling,
        "mood": mood,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
