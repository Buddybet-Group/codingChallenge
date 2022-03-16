import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import '../../data/network/http_client.dart';
import '../../data/constant/endpoints.dart';
import '../../models/nationality_response.dart';

class PostApi {
  // http instance
  final HttpClient _httpClient;

  // injecting http instance
  PostApi(this._httpClient);

  /// Returns list of countries in response
  Future<NationalityResposnse> getCountryList({required String searchKey}) async {
    try {
      final queryParameters = {'name': searchKey};
      final res = await _httpClient.get(Endpoints.baseUrl,
          queryParameters: queryParameters);
          print(res);
      return NationalityResposnse.fromJson(jsonDecode(res));
    } catch (error, _) {
      debugPrintStack(stackTrace: _);
      debugPrint(error.toString());
      rethrow;
    }
  }
}
