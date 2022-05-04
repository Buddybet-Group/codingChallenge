class ResponseModel {
  String name;
  List<dynamic> country;
  ResponseModel(this.name, this.country);

  ResponseModel.fromJson(json)
      : name = json['name'],
        country = json['country'];

  Map toJson() => {'name': name, 'country': country};
}

class Country {
  String country_id;
  double probability;
  Country(this.country_id, this.probability);

  Country.fromJson(json)
      : country_id = json['country_id'],
        probability = json['probability'];

  Map toJson() => {'country_id': country_id, 'probability': probability};
}
