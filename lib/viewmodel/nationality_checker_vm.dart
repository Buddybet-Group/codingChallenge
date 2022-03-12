import 'package:coding_chal/data/model/nationality_response.dart';
import 'package:coding_chal/data/remote/repository/nationality/nationality_imp.dart';
import 'package:coding_chal/data/remote/response/api_response.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NationalityCheckerViewModel extends ChangeNotifier {
  final _nationalityRepository = NationalityImpl(Client());
  ApiResponse<NationalityResponse> nationalityResponse = ApiResponse.none();

  String nationality = '';

  final String _nationalityNotFound = 'not found';

  void _setNationalityData(ApiResponse<NationalityResponse> response) {
    nationalityResponse = response;

    if (nationalityResponse.data?.country != null && nationalityResponse.data!.country!.isNotEmpty) {
      nationality = nationalityResponse.data?.country?.first.countryId ?? _nationalityNotFound;
      final String countryId = nationalityResponse.data?.country?.first.countryId ?? '';
      if (countryId.isNotEmpty) {
        final CountryDetails? name = CountryCodes.detailsForLocale(Locale('en', countryId));
        nationality = name?.localizedName ?? _nationalityNotFound;
      } else {
        nationality = _nationalityNotFound;
      }
    } else {
      nationality = _nationalityNotFound;
    }
    notifyListeners();
  }

  Future<void> fetchNationality(String name) async {
    _setNationalityData(ApiResponse.loading());
    _nationalityRepository
        .getNationality(name)
        .then((value) => _setNationalityData(ApiResponse.completed(value)))
        .onError((error, stackTrace) => _setNationalityData(ApiResponse.error(error.toString())));
  }
}
