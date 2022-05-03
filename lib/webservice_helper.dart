import 'package:coding_chal/model/base_response.dart';
import 'package:coding_chal/model/api_status.dart';
import 'model/nationality_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WebServiceHelper {
  WebServiceHelper._();

  static final WebServiceHelper _helper = WebServiceHelper._();

  factory WebServiceHelper() => _helper;

  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      switch (response.statusCode) {
        case 200:
          dynamic responseJson = jsonDecode(response.body);
          return ApiBaseResponse()
            ..statusCode = response.statusCode
            ..status = ApiStatus.success
            ..data = NationalityResponse.fromJson(responseJson);
        case 429:
          return ApiBaseResponse()
            ..statusCode = 429
            ..status = ApiStatus.error
            ..error = 'Request limit reached';
        case 422:
          return ApiBaseResponse()
            ..statusCode = 422
            ..status = ApiStatus.error
            ..error = "Missing 'name' parameter";
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
