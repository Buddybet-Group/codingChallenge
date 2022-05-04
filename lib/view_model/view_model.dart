import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/api.dart';
import '../model/country_model.dart';
import '../repo/apiCall.dart';
import '../utils/app.dart';
import '../utils/custom_widgets.dart';
import '../utils/loader.dart';

class ViewModel extends ChangeNotifier {
  TextEditingController nameControler = TextEditingController();
  List<dynamic> countries = List.empty(growable: true);

  ///calls the api to fetch the notifications

  getAPIData() async {
    countries = List.empty(growable: true);

    APIProvider apiProvider = APIProvider();
    var response = await apiProvider.callApi(
      httpVerb: APIs.get,
      endpoint: nameControler.text.trim(),
    );
    showLoaderDialog();
    ResponseModel responseModel =
        ResponseModel.fromJson(jsonDecode(response.body));
    print(jsonEncode(response.body));
    App.pop();
    if (responseModel.country.length > 0) {
      countries = responseModel.country;
    } else {
      showErrorSnackBar("No Data found.");
    }
    notifyListeners();
    // if (responseModel.status) {
    // } else {}
  }
}
