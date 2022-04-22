import 'dart:convert';

class Country {
  String countryId;
  double probability;
  Country({
    required this.countryId,
    required this.probability,
  });

  Map<String, dynamic> toMap() {
    return {
      'country_id': countryId,
      'probability': probability,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      countryId: map['country_id'] ?? '',
      probability: map['probability'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  @override
  String toString() =>
      'Country(country_id: $countryId, probability: $probability)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.countryId == countryId &&
        other.probability == probability;
  }

  @override
  int get hashCode => countryId.hashCode ^ probability.hashCode;
}
