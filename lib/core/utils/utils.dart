import 'dart:convert';

import 'package:coding_chal/core/values/assets.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Utility class for the app
class Utils {
  /// Creates new instance of util
  Utils() {
    _loadJsonIntoMemory();
  }

  Map<String, String> _countries = Map();

  Future<void> _loadJsonIntoMemory() async {
    String countryData = await rootBundle.loadString(Assets().countryNamesPath);
    dynamic data = jsonDecode(countryData);
    print('loaded data : ${data.runtimeType}: $data');
  }
}
