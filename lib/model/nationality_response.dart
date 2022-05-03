import 'package:json_annotation/json_annotation.dart';
import 'country.dart';

part 'nationality_response.g.dart';

@JsonSerializable()
class NationalityResponse {
  @JsonKey(name: 'name')
  late String name;

  @JsonKey(name: 'country')
  late List<Country> countries;

  NationalityResponse();

  factory NationalityResponse.fromJson(Map<String, dynamic> json) => _$NationalityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NationalityResponseToJson(this);
}

enum Status { none, loading, success, internetFailed }
