import 'package:flutter/foundation.dart';

@immutable
class Country {
  const Country({required this.countryId, required this.probability});

  final String countryId;
  final String probability;

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryId: json['country_id'],
      probability: json['probability'].toString(),
    );
  }
}