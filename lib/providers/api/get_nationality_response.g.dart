// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_nationality_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNationalityResponse _$GetNationalityResponseFromJson(
        Map<String, dynamic> json) =>
    GetNationalityResponse(
      name: json['name'] as String,
      countries: (json['country'] as List<dynamic>)
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetNationalityResponseToJson(
        GetNationalityResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'country': instance.countries,
    };
