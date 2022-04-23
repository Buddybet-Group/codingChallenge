import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/app_tools.dart';
import 'api_config.dart';
import 'app_exception.dart';

class ApiBaseHelper {
  // final NavigationService _navigationService = NavigationService();

  Future<dynamic> getApiCall(String url) async {
    dynamic responseJson;
    print('get - ${BASE_URL + url}');

    try {
      final response = await http
          .get(Uri.parse(BASE_URL + url), headers: <String, String>{});
      print(response.statusCode);
      print('response');
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        responseJson = _returnResponse(response);
      } else {
        showToast(response.reasonPhrase ?? "");
        responseJson = _returnResponse(response);
      }
    } on SocketException {
      // Fluttertoast.showToast(msg: "Please Check your internec connection");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      // throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
