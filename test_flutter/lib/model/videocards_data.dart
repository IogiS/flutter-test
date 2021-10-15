// To parse this JSON data, do
//
//     final videocardsData = videocardsDataFromJson(jsonString);

import 'dart:convert';

List<VideocardsData> videocardsDataFromJson(String str) =>
    List<VideocardsData>.from(
        json.decode(str).map((x) => VideocardsData.fromJson(x)));

String videocardsDataToJson(List<VideocardsData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideocardsData {
  VideocardsData({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.img,
  });

  int id;
  String name;
  Manufacturer? manufacturer;
  String img;

  factory VideocardsData.fromJson(Map<String, dynamic> json) => VideocardsData(
        id: json["id"],
        name: json["name"],
        manufacturer: manufacturerValues.map[json["Manufacturer"]],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "Manufacturer": manufacturerValues.reverse![manufacturer],
        "img": img,
      };
}

enum Manufacturer { NVIDIA, AMD }

final manufacturerValues =
    EnumValues({"AMD": Manufacturer.AMD, "NVIDIA": Manufacturer.NVIDIA});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
