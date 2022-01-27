// To parse this JSON data, do
//
//     final nationalResponse = nationalResponseFromJson(jsonString);

import 'dart:convert';

NationalResponse nationalResponseFromJson(String str) => NationalResponse.fromJson(json.decode(str));

String nationalResponseToJson(NationalResponse data) => json.encode(data.toJson());

class NationalResponse {
    NationalResponse({
        this.name,
        this.country,
    });

    final String? name;
    final List<Country>? country;

    factory NationalResponse.fromJson(Map<String, dynamic> json) => NationalResponse(
        name: json["name"] == null ? null : json["name"],
        country: json["country"] == null ? null : List<Country>.from(json["country"].map((x) => Country.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "country": country == null ? null : List<dynamic>.from(country!.map((x) => x.toJson())),
    };
}

class Country {
    Country({
        this.countryId,
        this.probability,
    });

    final String? countryId;
    final double? probability;

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryId: json["country_id"] == null ? null : json["country_id"],
        probability: json["probability"] == null ? null : json["probability"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "country_id": countryId == null ? null : countryId,
        "probability": probability == null ? null : probability,
    };
}
