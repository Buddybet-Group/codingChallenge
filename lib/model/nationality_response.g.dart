// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nationality_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NationalityResponse _$NationalityResponseFromJson(Map<String, dynamic> json) => NationalityResponse()
  ..name = json['name'] as String
  ..countries = (json['country'] as List<dynamic>)
      .map((e) => Country.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$NationalityResponseToJson(NationalityResponse instance) =>
    <String, dynamic>{'name': instance.name, 'country': instance.countries};
