import 'package:coding_chal/constants.dart';
import 'package:coding_chal/model/base_response.dart';
import 'package:coding_chal/webservice_helper.dart';
import 'package:flutter/cupertino.dart';

class NationalityRepository {
  static Future<ApiBaseResponse> fetchNationalityData(BuildContext context, String name) async {
    return await WebServiceHelper().get(Constants.baseUrl + Constants.namePathUrl + name);
  }
}
