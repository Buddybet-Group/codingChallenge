import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:coding_chal/model/Country.dart';

class Prediction {
  final String name;
  final List<Country> countryList;
  const Prediction({
    required this.name,
    required this.countryList,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'countryList': countryList.map((x) => x.toMap()).toList(),
    };
  }

  factory Prediction.fromMap(Map<String, dynamic> map) {
    return Prediction(
      name: map['name'] ?? '',
      countryList:
          List<Country>.from(map['country']?.map((x) => Country.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Prediction.fromJson(String source) =>
      Prediction.fromMap(json.decode(source));

  @override
  String toString() => 'Prediction(name: $name, countryList: $countryList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Prediction &&
        other.name == name &&
        listEquals(other.countryList, countryList);
  }

  @override
  int get hashCode => name.hashCode ^ countryList.hashCode;
}
