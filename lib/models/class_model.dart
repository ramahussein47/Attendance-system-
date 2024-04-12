import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
    String day;
    String time;
    String welcomeClass;

    Welcome({
        required this.day,
        required this.time,
        required this.welcomeClass,
    });

    Welcome copyWith({
        String? day,
        String? time,
        String? welcomeClass,
    }) =>
        Welcome(
            day: day ?? this.day,
            time: time ?? this.time,
            welcomeClass: welcomeClass ?? this.welcomeClass,
        );

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        day: json["day"],
        time: json["time"],
        welcomeClass: json["class"],
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "time": time,
        "class": welcomeClass,
    };
    }
