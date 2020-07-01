import 'dart:convert';

List<DetailModel> detailDataFromJson(String str) =>
    List<DetailModel>.from(json.decode(str).map((x) => DetailModel.fromMap(x)));

class DetailModel {
  DetailModel({
    this.provinceState,
    this.countryRegion,
    this.lastUpdate,
    this.confirmed,
    this.recovered,
    this.deaths,
    this.combinedKey,
  });

  final String provinceState;
  final String countryRegion;
  final int lastUpdate;
  final int confirmed;
  final int recovered;
  final int deaths;
  final String combinedKey;

  DetailModel copyWith({
    String provinceState,
    String countryRegion,
    int lastUpdate,
    int confirmed,
    int recovered,
    int deaths,
    String combinedKey,
  }) =>
      DetailModel(
        provinceState: provinceState ?? this.provinceState,
        countryRegion: countryRegion ?? this.countryRegion,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        confirmed: confirmed ?? this.confirmed,
        recovered: recovered ?? this.recovered,
        deaths: deaths ?? this.deaths,
        combinedKey: combinedKey ?? this.combinedKey,
      );

  factory DetailModel.fromJson(String str) =>
      DetailModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailModel.fromMap(Map<String, dynamic> json) => DetailModel(
        provinceState: json["provinceState"] ?? '',
        countryRegion: json["countryRegion"],
        lastUpdate: json["lastUpdate"],
        confirmed: json["confirmed"],
        recovered: json["recovered"],
        deaths: json["deaths"],
        combinedKey: json["combinedKey"],
      );

  Map<String, dynamic> toMap() => {
        "provinceState": provinceState ?? null,
        "countryRegion": countryRegion,
        "lastUpdate": lastUpdate,
        "confirmed": confirmed,
        "recovered": recovered,
        "deaths": deaths,
        "combinedKey": combinedKey,
      };
}
