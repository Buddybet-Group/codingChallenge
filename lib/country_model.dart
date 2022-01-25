class CountryModel {
  final String countryId;
  final num probability;

  CountryModel(this.countryId, this.probability);

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      json['country_id'],
      json['probability'],
    );
  }
}
