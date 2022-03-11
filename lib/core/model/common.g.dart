// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonResponse _$CommonResponseFromJson(Map<String, dynamic> json) =>
    CommonResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CommonResponseToJson(CommonResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      language_code: json['language_code'] as String?,
      country_code: json['country_code'] as String?,
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'language_code': instance.language_code,
      'country_code': instance.country_code,
    };

NationalizeResponse _$NationalizeResponseFromJson(Map<String, dynamic> json) =>
    NationalizeResponse(
      error: json['error'] as String?,
      name: json['name'] as String?,
      country: json['country'] as List<dynamic>?,
    );

Map<String, dynamic> _$NationalizeResponseToJson(
        NationalizeResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'name': instance.name,
      'country': instance.country,
    };
