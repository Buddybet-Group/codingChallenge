import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/config.dart';
import '../../core/domain/repository/api_respository.dart';
import '../models/result_model.dart';

@immutable
class ApiService extends ApiRespository {
  static final Dio _dio = Dio();

  @override
  Future<SearchResultModel> fetchResults(String name) async {
    try {
      Response response =
          await _dio.get(Config.nameSearchURL, queryParameters: {
        'name': name,
      });

      if (response.statusCode == 200) {
        return SearchResultModel.fromJson(response.data);
      } else {
        throw 'Something went wrong. Please try again later!';
      }
    } on DioError catch (error) {
      rethrow;
    }
  }
}
