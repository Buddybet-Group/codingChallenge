import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'dart:io';
import '../../../core/constants/entity_factory.dart';
import 'package:http/http.dart' as http;

class HttpService {
  http.Response? response;

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  Future<dynamic> request(
      {required String url,
      required Method method,
      Map<String, dynamic>? queryParams,
      dynamic data,
      Function? onError,
      void onSuccess(dynamic data)?}) async {
    print(url);
    try {
      switch (method) {
        case Method.get:
          http.Response response =
              await http.get(Uri.parse(url), headers: headers);
          var responsedata = json.decode(response.body);
          if (onSuccess != null && responsedata != null) {
            onSuccess(responsedata);
          }
          return responsedata;

        case Method.post:
          http.Response response = await http.post(Uri.parse(url),
              body: json.encode(queryParams), headers: headers);
          var responsedata = json.decode(response.body);
          if (onSuccess != null && responsedata != null) {
            onSuccess(responsedata);
          }
          return responsedata;
      }
    } catch (e, s) {
      if (onSuccess != null) {
        onSuccess({
          "Status": false,
          "Message": "Check you're Domain / Internet Connection! 👎"
        });
      }
      return {
        "Status": false,
        "Message": "Check you're Domain / Internet Connection! 👎"
      };
      print("jdfsdfjkjdskjfhdskjfsd" + e.toString());
    } on SocketException {
      print('No Internet connection 😑');
      if (onError != null) {
        // onError(response!.statusCode, response!.statusMessage);
      }
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }
  }
}
