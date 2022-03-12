import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'app_exception.dart';
import 'base_api.dart';

class ApiService extends BaseApiService {
  final Client _client;

  ApiService(this._client);

  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await _client.get(Uri.parse(apiBaseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(response.reasonPhrase ?? 'Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }
}
