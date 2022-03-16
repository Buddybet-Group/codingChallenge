// ignore_for_file: non_constant_identifier_names

class Country {
  String? countryId;
  double? probability;

  Country({
    this.countryId,
    this.probability,
  });

   Country.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    probability = json['probability'];
  }

  Map<String, dynamic> toMap() =>
      {"country_id": countryId, "probability": probability};
}
