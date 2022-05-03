// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country()
  ..countryId = json['country_id'] as String
  ..probability = (json['probability'] as num).toDouble();

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'country_id': instance.countryId,
      'probability': instance.probability,
    };
