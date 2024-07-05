import 'package:meta/meta.dart';
import 'dart:convert';

StatisticsModel statisticsModelFromJson(String str) =>
    StatisticsModel.fromJson(json.decode(str));

String statisticsModelToJson(StatisticsModel data) =>
    json.encode(data.toJson());

class StatisticsModel {
  String? message;
  bool result;
  Data data;

  StatisticsModel({
    required this.message,
    required this.result,
    required this.data,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) =>
      StatisticsModel(
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
  int streak;
  int posts;
  int notes;
  User user;

  Data({
    required this.streak,
    required this.posts,
    required this.notes,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        streak: json["streak"],
        posts: json["posts"],
        notes: json["notes"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "streak": streak,
        "posts": posts,
        "notes": notes,
        "user": user.toJson(),
      };
}

class User {
  List<dynamic> goals;
  List<dynamic> elevates;
  List<dynamic> motivations;
  String? growthTime;
  bool stayOnTrack;
  bool personalGrowth;
  bool movingForward;
  String? lifeGoals;
  String? yearGoals;
  String? plan;
  bool block;
  String id;
  String email;
  String name;
  String gender;
  String age;
  String? image;
  bool verified;
  DateTime createdAt;
  DateTime updatedAt;

  User({
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
    required this.id,
    required this.email,
    required this.name,
    required this.gender,
    required this.age,
    required this.image,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        goals: List<dynamic>.from(json["goals"].map((x) => x)),
        elevates: List<dynamic>.from(json["elevates"].map((x) => x)),
        motivations: List<dynamic>.from(json["motivations"].map((x) => x)),
        growthTime: json["growthTime"] ?? '',
        stayOnTrack: json["stayOnTrack"],
        personalGrowth: json["personalGrowth"],
        movingForward: json["movingForward"],
        lifeGoals: json["lifeGoals"] ?? '',
        yearGoals: json["yearGoals"] ?? '',
        plan: json["plan"] ?? '',
        block: json["block"],
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        gender: json["gender"],
        age: json["age"],
        image: json["image"] ?? '',
        verified: json["verified"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
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
        "_id": id,
        "email": email,
        "name": name,
        "gender": gender,
        "age": age,
        "image": image,
        "verified": verified,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
