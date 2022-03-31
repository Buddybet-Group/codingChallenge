

import 'dart:convert';
import 'dart:io';

import 'package:buddybet_assignment/constant/serverip.dart';
import 'package:buddybet_assignment/model/country_model.dart';
import 'package:dio/dio.dart';


class ApiController {
  Future<List<Country_model>> getCountryList() async{
    List<Country_model> data = <Country_model>[];
    try{
      String url = '${ServerIP().baseUrl}/?name[]=michael&name[]=matthew&name[]=jane';
      var response = await Dio().get(
          url,
          options: Options(
              headers: {
                HttpHeaders.contentTypeHeader: "application/json"
              }
          )
      );

      if(response.statusCode == 200){

        data = (response.data as List).map((model) => Country_model.fromJson(model)).toList();

      }
    }on DioError catch(e){
      // print(e);
    }

    return data;
  }
  Future<Country_model> searchCountryList(name) async{
    Country_model data = Country_model();
    try{
      String url = '${ServerIP().baseUrl}/?name=$name';
      var response = await Dio().get(
          url,
          options: Options(
              headers: {
                HttpHeaders.contentTypeHeader: "application/json"
              }
          )
      );

      if(response.statusCode == 200){
        data = Country_model.fromJson(response.data);
      }
    }on DioError catch(e){
      // print(e);
    }

    return data;
  }

}