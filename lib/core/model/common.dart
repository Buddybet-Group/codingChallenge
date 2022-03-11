import 'package:json_annotation/json_annotation.dart';
part 'common.g.dart';

@JsonSerializable()
class CommonResponse {
  String? status;
  String? message;

  CommonResponse({this.status, this.message});

  factory CommonResponse.fromJson(Map<dynamic, dynamic> json) =>
      _$CommonResponseFromJson(json as Map<String, dynamic>);
  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);
}

@JsonSerializable()
class Language {
  String? language_code;
  String? country_code;

  Language({
    this.language_code,
    this.country_code,
  });

  factory Language.fromJson(Map<dynamic, dynamic> json) =>
      _$LanguageFromJson(json as Map<String, dynamic>);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}

@JsonSerializable()
class NationalizeResponse {
  String? error;
  String? name;
  List? country;

  NationalizeResponse({this.error, this.name, this.country});

  factory NationalizeResponse.fromJson(Map<dynamic, dynamic> json) =>
      _$NationalizeResponseFromJson(json as Map<String, dynamic>);
  Map<String, dynamic> toJson() => _$NationalizeResponseToJson(this);
}
