import 'dart:convert';

import 'package:coding_chal/core/values/assets.dart';
import 'package:coding_chal/providers/api/country.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Utility class for the app
class Utils {
  final Map<String, String> _countries = Map();

  Future<void> loadJsonIntoMemory() async {
    /// TODO Handle failures
    try {
      rootBundle.loadString(Assets().countryNamesPath).then((value) {
        dynamic data = jsonDecode(value);
        data.forEach((element) {
          _countries[element["code"] ?? ""] = element['name'] ?? "";
        });
      });
    } catch (e) {
      /// Ignore for now
    }
  }

  String? getCountryName(String countryId) {
    return _countries[countryId];
  }

  Country getHighProbablity(List<Country> countries) {
    countries.sort(
      (a, b) {
        return b.probability > a.probability ? 1 : 0;
      },
    );
    return countries[0];
  }
}
