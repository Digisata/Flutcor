import 'package:meta/meta.dart';
import 'dart:convert';

class CoronaModel {
  CoronaModel({
    this.confirmed,
    this.recovered,
    this.deaths,
    this.dailySummary,
    this.dailyTimeSeries,
    this.image,
    this.source,
    this.countries,
    this.countryDetail,
    this.lastUpdate,
  });

  final Confirmed confirmed;
  final Confirmed recovered;
  final Confirmed deaths;
  final String dailySummary;
  final CountryDetail dailyTimeSeries;
  final String image;
  final String source;
  final String countries;
  final CountryDetail countryDetail;
  final DateTime lastUpdate;

  CoronaModel copyWith({
    Confirmed confirmed,
    Confirmed recovered,
    Confirmed deaths,
    String dailySummary,
    CountryDetail dailyTimeSeries,
    String image,
    String source,
    String countries,
    CountryDetail countryDetail,
    DateTime lastUpdate,
  }) =>
      CoronaModel(
        confirmed: confirmed ?? this.confirmed,
        recovered: recovered ?? this.recovered,
        deaths: deaths ?? this.deaths,
        dailySummary: dailySummary ?? this.dailySummary,
        dailyTimeSeries: dailyTimeSeries ?? this.dailyTimeSeries,
        image: image ?? this.image,
        source: source ?? this.source,
        countries: countries ?? this.countries,
        countryDetail: countryDetail ?? this.countryDetail,
        lastUpdate: lastUpdate ?? this.lastUpdate,
      );

  factory CoronaModel.fromJson(String str) =>
      CoronaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CoronaModel.fromMap(Map<String, dynamic> json) => CoronaModel(
        confirmed: Confirmed.fromMap(json["confirmed"]),
        recovered: Confirmed.fromMap(json["recovered"]),
        deaths: Confirmed.fromMap(json["deaths"]),
        dailySummary: json["dailySummary"],
        dailyTimeSeries: CountryDetail.fromMap(json["dailyTimeSeries"]),
        image: json["image"],
        source: json["source"],
        countries: json["countries"],
        countryDetail: CountryDetail.fromMap(json["countryDetail"]),
        lastUpdate: DateTime.parse(json["lastUpdate"]),
      );

  Map<String, dynamic> toMap() => {
        "confirmed": confirmed.toMap(),
        "recovered": recovered.toMap(),
        "deaths": deaths.toMap(),
        "dailySummary": dailySummary,
        "dailyTimeSeries": dailyTimeSeries.toMap(),
        "image": image,
        "source": source,
        "countries": countries,
        "countryDetail": countryDetail.toMap(),
        "lastUpdate": lastUpdate.toIso8601String(),
      };
}

class Confirmed {
  Confirmed({
    @required this.value,
    @required this.detail,
  });

  final int value;
  final String detail;

  Confirmed copyWith({
    int value,
    String detail,
  }) =>
      Confirmed(
        value: value ?? this.value,
        detail: detail ?? this.detail,
      );

  factory Confirmed.fromJson(String str) => Confirmed.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Confirmed.fromMap(Map<String, dynamic> json) => Confirmed(
        value: json["value"],
        detail: json["detail"],
      );

  Map<String, dynamic> toMap() => {
        "value": value,
        "detail": detail,
      };
}

class CountryDetail {
  CountryDetail({
    @required this.pattern,
    @required this.example,
  });

  final String pattern;
  final String example;

  CountryDetail copyWith({
    String pattern,
    String example,
  }) =>
      CountryDetail(
        pattern: pattern ?? this.pattern,
        example: example ?? this.example,
      );

  factory CountryDetail.fromJson(String str) =>
      CountryDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CountryDetail.fromMap(Map<String, dynamic> json) => CountryDetail(
        pattern: json["pattern"],
        example: json["example"],
      );

  Map<String, dynamic> toMap() => {
        "pattern": pattern,
        "example": example,
      };
}
