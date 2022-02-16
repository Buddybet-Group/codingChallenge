import 'package:json_annotation/json_annotation.dart';
import 'country.dart';

part 'get_nationality_response.g.dart';

/// Response from the server when requesting nationality
@JsonSerializable()
class GetNationalityResponse {
  /// Creates new instance
  GetNationalityResponse({required this.name, required this.countries});

  /// Converts json to model
  factory GetNationalityResponse.fromJson(Map<String, dynamic> json) =>
      _$GetNationalityResponseFromJson(json);

  /// name entered by user
  @JsonKey(name: 'name')
  final String name;

  /// inner country object
  @JsonKey(name: 'country')
  final List<Country> countries;

  /// Converts model to json
  Map<String, dynamic> toJson() => _$GetNationalityResponseToJson(this);
}
