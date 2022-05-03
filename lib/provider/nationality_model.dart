import 'package:coding_chal/utils/country_name_utils.dart';

import '../model/base_response.dart';
import '../model/api_status.dart';
import '../repository/nationality_repository.dart';
import '../model/country.dart';
import '../theme/string_resources.dart';
import '../utils/network.dart';
import 'package:flutter/material.dart';

class NationalityModel extends ChangeNotifier {
  ApiBaseResponse _apiResponse = ApiBaseResponse();
  final List<Country> _countryList = [];

  List<Country> get getCountries => _countryList;

  ApiBaseResponse getResponse() => _apiResponse;

  String getNationality(String countryId) {
    if (countryId.isNotEmpty) {
      return CountryNameUtils.codes[countryId]['name'];
    }
    return '';
  }

  void fetchNationalityData(BuildContext context, String name) async {
    _apiResponse.status = ApiStatus.loading;
    notifyListeners();
    if (await Network.checkInternetAvailability()) {
      _apiResponse = await NationalityRepository.fetchNationalityData(context, name);
      if (_apiResponse.status == ApiStatus.success &&
          _apiResponse.data != null &&
          _apiResponse.data!.countries.isNotEmpty) {
        _countryList.addAll(_apiResponse.data!.countries);
      } else if (_apiResponse.status == ApiStatus.success && _apiResponse.data!.countries.isEmpty) {
        _apiResponse.error = StringResources.noMatchingNationalityFound;
        showSnackBarMsg(context, _apiResponse.error);
      } else {
        _apiResponse.status = ApiStatus.none;
        showSnackBarMsg(context, _apiResponse.error);
      }
      notifyListeners();
    } else {
      _apiResponse.status = ApiStatus.none;
      notifyListeners();
      showSnackBarMsg(context);
    }
  }

  void submitName(context, String name) {
    if (name.isNotEmpty && RegExp(r"^[a-zA-z]+([\s][a-zA-Z]+)*$").hasMatch(name)) {
      fetchNationalityData(context, name);
    } else {
      showSnackBarMsg(context, StringResources.pleaseEnterText);
    }
  }

  void showSnackBarMsg(BuildContext context, [String? msg]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(msg ?? StringResources.checkYourInternet, style: Theme.of(context).textTheme.button),
        backgroundColor: Colors.blueAccent));
  }
}
