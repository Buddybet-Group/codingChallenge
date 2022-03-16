import 'dart:async';

import 'network/country_api.dart';
import '../models/nationality_response.dart';

class Repository {
  // api objects
  final PostApi _postApi;

  // constructor
  Repository(this._postApi);

  // Post: ---------------------------------------------------------------------
  Future<NationalityResposnse> getCountryList({required String searchKey}) async {
    // make a network call to get all country
    return await _postApi.getCountryList(searchKey: searchKey).then((countryList) {      
      print(countryList);
      return countryList;
    }).catchError((error, obj) {
      print(obj);
      throw error;
    });
  }
}
