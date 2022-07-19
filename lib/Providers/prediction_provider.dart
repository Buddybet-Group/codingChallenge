import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../nationality_model.dart';

class ProProvider with ChangeNotifier {

  static Future<Object?> getCountry(String country) async {
    try {

      Dio dio = Dio();

      final response = await dio.get('https://api.nationalize.io?name=$country',);

      NationalityMOdel obj = NationalityMOdel.fromJson(response.data);

      return obj.country[0].countryId;

    } catch (e) {
      print('Error : ' + e.toString());
      return null;
    }
  }

}