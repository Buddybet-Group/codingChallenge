import 'package:json_annotation/json_annotation.dart';
part 'country.g.dart';

/// The model that holds data of Country
@JsonSerializable()
class Country {
  /// Creates a new instance
  Country({
    required this.countryId,
    required this.probability,
  });

  /// Contains country's unique id like Australia => AU
  @JsonKey(name: 'country_id')
  final String countryId;

  /// Probability of results range between 0-1, higher is better
  @JsonKey(name: 'probability')
  final double probability;

  /// Name of the country like "Australia"
  /// Typically filled at the repository
  String? countryName;

  String get flagUrl => "http://www.geonames.org/flags/x/$countryId.gif".toLowerCase();

  /// Converts json to model
  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  /// Converts model to json
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
