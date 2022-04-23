import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

CountryDetails countryName(String? countryId) {
  return CountryCodes.detailsForLocale(
      Locale(countryId!.toLowerCase(), countryId));
}

Future<dynamic> showToast(String message) {
  return Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
}
