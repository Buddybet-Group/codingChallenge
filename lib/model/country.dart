class Country {
  Country({
      String? countryId,
      double probability = 0,}){
    _countryId = countryId;
    _probability = probability;
}

  Country.fromJson(dynamic json) {
    _countryId = json['country_id'];
    _probability = json['probability']??0;
  }
  String? _countryId;
  double _probability = 0;

  String? get countryId => _countryId;
  double get probability => _probability;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country_id'] = _countryId;
    map['probability'] = _probability;
    return map;
  }

  @override
  String toString() {

    return 'There is $probability probability you belong to $_countryId';
  }
}