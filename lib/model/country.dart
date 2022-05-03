import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country {
  @JsonKey(name: 'country_id')
  late String countryId;

  @JsonKey(name: 'probability')
  late double probability;

  Country();

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
