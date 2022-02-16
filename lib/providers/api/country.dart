import 'package:json_annotation/json_annotation.dart';
part 'country.g.dart';

/// The model that holds data of Country class
@JsonSerializable()
class Country {
  /// Creates a new instance
  Country({
    required this.country_id,
    required this.probability,
  });

  /// Contains country's unique id like Australia => AU
  final String country_id;

  /// Probability of results range between 0-1, higher is better
  final double probability;

  /// Name of the country like "Australia"
  /// Typically filled at the repository
  String? countryName;

  /// Returns flag url
  /// TODO Move to StringManager
  String getFlagUrl() {
    return "http://www.geonames.org/flags/x/$country_id.gif";
  }
}
