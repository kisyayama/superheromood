// lib/model/herodata.dart
import 'dart:convert';

HeroData heroDataFromJson(String str) => HeroData.fromJson(jsonDecode(str));

class HeroData {
  String? response;
  String? resultsFor;
  List<Result>? results;

  HeroData({this.response, this.resultsFor, this.results});

  factory HeroData.fromJson(Map<String, dynamic> json) => HeroData(
    response: json["response"],
    resultsFor: json["results-for"],
    results: json["results"] == null
        ? null
        : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );
}

class Result {
  String? id;
  String? name;
  String? img; // Diubah dari 'image' menjadi 'img' sesuai poin 6 & 7 di modul

  Result({this.id, this.name, this.img});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    img: json["image"] != null
        ? json["image"]["url"]
        : null, // Pemetaan URL langsung ke img sesuai poin 7 modul
  );
}
