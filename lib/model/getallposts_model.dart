// To parse this JSON data, do
//
//     final getAllPostsModel = getAllPostsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetAllPostsModel getAllPostsModelFromJson(String str) =>
    GetAllPostsModel.fromJson(json.decode(str));

String getAllPostsModelToJson(GetAllPostsModel data) =>
    json.encode(data.toJson());

class GetAllPostsModel {
  String message;
  bool result;
  List<Datum> data;

  GetAllPostsModel({
    required this.message,
    required this.result,
    required this.data,
  });

  factory GetAllPostsModel.fromJson(Map<String, dynamic> json) =>
      GetAllPostsModel(
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
  UserId userId;
  Mood mood;
  List<Mood> activities;
  List<Mood> feelings;
  bool goalAchieve;
  Note note;
  String dayDescription;
  String tomorrowDescription;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.userId,
    required this.mood,
    required this.activities,
    required this.feelings,
    required this.goalAchieve,
    required this.note,
    required this.dayDescription,
    required this.tomorrowDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        mood: Mood.fromJson(json["mood"]),
        activities:
            List<Mood>.from(json["activities"].map((x) => Mood.fromJson(x))),
        feelings:
            List<Mood>.from(json["feelings"].map((x) => Mood.fromJson(x))),
        goalAchieve: json["goalAchieve"],
        note: Note.fromJson(json["note"]),
        dayDescription: json["dayDescription"],
        tomorrowDescription: json["tomorrowDescription"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "mood": mood.toJson(),
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
        "feelings": List<dynamic>.from(feelings.map((x) => x.toJson())),
        "goalAchieve": goalAchieve,
        "note": note.toJson(),
        "dayDescription": dayDescription,
        "tomorrowDescription": tomorrowDescription,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Mood {
  String id;
  String title;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  String path;

  Mood({
    required this.id,
    required this.title,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.path,
  });

  factory Mood.fromJson(Map<String, dynamic> json) => Mood(
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

class Note {
  String id;
  String note;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String path;

  Note({
    required this.id,
    required this.note,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.path,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["_id"],
        note: json["note"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "note": note,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "path": path,
      };
}

class UserId {
  String id;
  String email;
  String name;
  bool verified;
  String gender;
  String age;
  List<String> goals;
  List<String> elevates;
  List<String> motivations;
  String growthTime;
  bool stayOnTrack;
  bool personalGrowth;
  bool movingForward;
  String lifeGoals;
  String yearGoals;
  String plan;
  bool block;
  DateTime createdAt;
  DateTime updatedAt;

  UserId({
    required this.id,
    required this.email,
    required this.name,
    required this.verified,
    required this.gender,
    required this.age,
    required this.goals,
    required this.elevates,
    required this.motivations,
    required this.growthTime,
    required this.stayOnTrack,
    required this.personalGrowth,
    required this.movingForward,
    required this.lifeGoals,
    required this.yearGoals,
    required this.plan,
    required this.block,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        verified: json["verified"],
        gender: json["gender"],
        age: json["age"],
        goals: List<String>.from(json["goals"].map((x) => x)),
        elevates: List<String>.from(json["elevates"].map((x) => x)),
        motivations: List<String>.from(json["motivations"].map((x) => x)),
        growthTime: json["growthTime"],
        stayOnTrack: json["stayOnTrack"],
        personalGrowth: json["personalGrowth"],
        movingForward: json["movingForward"],
        lifeGoals: json["lifeGoals"],
        yearGoals: json["yearGoals"],
        plan: json["plan"],
        block: json["block"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "verified": verified,
        "gender": gender,
        "age": age,
        "goals": List<dynamic>.from(goals.map((x) => x)),
        "elevates": List<dynamic>.from(elevates.map((x) => x)),
        "motivations": List<dynamic>.from(motivations.map((x) => x)),
        "growthTime": growthTime,
        "stayOnTrack": stayOnTrack,
        "personalGrowth": personalGrowth,
        "movingForward": movingForward,
        "lifeGoals": lifeGoals,
        "yearGoals": yearGoals,
        "plan": plan,
        "block": block,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
