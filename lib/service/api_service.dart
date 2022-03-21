import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService{
static const String baseUrl = "https://api.nationalize.io?";

 static Future<dynamic> get({required final String endPointParams, Map<String, String?>? headers,}) async {

    String url = baseUrl +endPointParams;
    debugPrint("get: "+url +", headers: " +headers.toString());
    final http.Response response = await http.get(Uri.parse(url), headers: headers as Map<String, String>?);

    try {
      if(response.statusCode == 200){
        Map<String, dynamic>?   jsonData = jsonDecode(response.body);
        debugPrint("get: "+url+", response: "+ jsonData.toString());
        return jsonData;

      }


    } catch (e) {
      debugPrint(e.toString());
    }
    return response.body;

  }
}