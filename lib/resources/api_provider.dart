import 'dart:ffi';
import 'dart:io';

import 'package:coding_chal/data/models/predict_model.dart';
import 'package:dio/dio.dart';
import 'package:ffi/ffi.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://api.nationalize.io/';

  Future<Prediction> fetchItemList(Map<String, dynamic> queryParams) async {

    Response response = await _dio.get(_url, queryParameters: queryParams);
    if(response.statusCode == 200) {
      return Prediction.fromJson(response.data);
    }

    Prediction prediction = Prediction(name: '', countries: []);
    prediction.error = "network_error";
    return prediction;
  }
}
