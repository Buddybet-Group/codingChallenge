import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  // dio instance
  final http.Client _http;

  // injecting dio instance
  HttpClient(this._http);

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(String url,
      {Map<String, String>? headers,
      Map<String, String>? queryParameters}) async {
    try {
      final Uri uri = Uri.http(url, '', queryParameters);
      final http.Response response = await _http.get(
        uri,
        headers: headers,
      );
      return response.body;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
