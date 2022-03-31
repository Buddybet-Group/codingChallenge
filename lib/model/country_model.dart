// ignore: camel_case_types

import 'dart:convert';

class Country_model {
  Country_model({
    this.name,
    this.country,
  });

  String? name;
  List<Country>? country;

  factory Country_model.fromJson(Map<String, dynamic> json) => Country_model(
    name: json["name"],
    country:json['country'] ==null ? []: List<Country>.from(json["country"].map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "country": List<dynamic>.from(country!.map((x) => x.toJson())),
  };
}

class Country {
  Country({
    this.countryId,
    this.probability,
  });

  String? countryId;
  double? probability;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    countryId: json["country_id"] == null? null: json["country_id"],
    probability:json["probability"] == null? null: json["probability"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "country_id": countryId == null? null:countryId,
    "probability": probability == null? null: probability,
  };
}

