// To parse this JSON data, do
//
//     final nationalityMOdel = nationalityMOdelFromJson(jsonString);

import 'dart:convert';

NationalityMOdel nationalityMOdelFromJson(String str) => NationalityMOdel.fromJson(json.decode(str));

String nationalityMOdelToJson(NationalityMOdel data) => json.encode(data.toJson());

class NationalityMOdel {
  NationalityMOdel({
    required this.name,
    required this.country,
  });

  String name;
  List<Country> country;

  factory NationalityMOdel.fromJson(Map<String, dynamic> json) => NationalityMOdel(
    name: json["name"],
    country: List<Country>.from(json["country"].map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "country": List<dynamic>.from(country.map((x) => x.toJson())),
  };
}

class Country {
  Country({
    required this.countryId,
    required this.probability,
  });

  String countryId;
  double probability;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    countryId: json["country_id"],
    probability: json["probability"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "country_id": countryId,
    "probability": probability,
  };
}
