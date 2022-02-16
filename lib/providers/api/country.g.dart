// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      country_id: json['country_id'] as String,
      probability: (json['probability'] as num).toDouble(),
    )..countryName = json['countryName'] as String?;

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'country_id': instance.country_id,
      'probability': instance.probability,
      'countryName': instance.countryName,
    };
