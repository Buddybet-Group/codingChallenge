class CountryModel {
  String? name;
  List<Country>? country;

  CountryModel({this.name, this.country});

  CountryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(Country.fromJson(v));
      });
    }
  }
}

class Country {
  String? countryId;
  double? probability;

  Country({this.countryId, this.probability});

  Country.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    probability = double.parse(json['probability'].toString());
  }
}
