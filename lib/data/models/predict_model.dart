class Prediction {
  late String name;
  late List<Country> countries;
  String? error;

  Prediction({required this.name, required this.countries});

  Prediction.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['country'] != null) {
      countries = <Country>[];
      json['country'].forEach((v) {
        countries.add(Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (countries != null) {
      data['country'] = countries.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  late String countryId;
  late double probability;

  Country({required this.countryId, required this.probability});

  Country.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'] ?? "";
    probability = json['probability'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['probability'] = probability;
    return data;
  }
}
