import 'dart:convert';

import 'package:http/http.dart';

import '../constant/api.dart';
import '../utils/connection.dart';
import '../utils/custom_widgets.dart';

class APIProvider {
  String uatUrl = '';
  Client client = Client();
  Connection connection = Connection();

  Future<dynamic> callApi(
      {required String httpVerb,
      required String endpoint,
      String authToken = '',
      dynamic body,
      String baseUrl = APIs.baseUrl}) async {
    try {
      var isOnline = await connection.isOnline();
      if (isOnline) {
        var url = Uri.parse(baseUrl + endpoint);
        print(url);
        Map<String, String> headers = {'Content-Type': 'application/json'};
        if (authToken.isNotEmpty) {
          headers.addAll({'Authorization': authToken});
        }
        Response? response;
        switch (httpVerb) {
          case APIs.get:
            response = await client.get(url, headers: headers);
            break;
          case APIs.post:
            response = await client.post(url,
                body: json.encode(body), headers: headers);

            break;
          case APIs.patch:
            response = await client.patch(url,
                body: json.encode(body), headers: headers);

            break;
          case APIs.put:
            response = await client.put(url,
                body: json.encode(body), headers: headers);

            break;
          case APIs.delete:
            response = await client.delete(url,
                body: json.encode(body), headers: headers);

            break;
        }

        if (response?.statusCode == 200) {
          return response;
        } else {
          showErrorSnackBar("Please Connect to internet");
        }
      } else {
        showErrorSnackBar("Please Connect to internet");
        return {'message': "Please Connect to internet"};
      }
    } catch (e) {
      showErrorSnackBar(e.toString());
      return {'message': e.toString()};
    }
  }
}
