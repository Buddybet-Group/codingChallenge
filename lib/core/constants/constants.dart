import '../../core/constants/entity_factory.dart';
import '../../core/constants/shared_preferences_utils_impl.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;

bool isWeb = kIsWeb;
AppType appType = AppType.Debug;

enum EnvType { dev, production }

class EnvTypeHelper {
  static EnvType getType(String? name) {
    switch (name) {
      case 'dev':
        return EnvType.dev;
      case 'production':
        return EnvType.production;
      default:
        return EnvType.dev;
    }
  }

  static String getValue(EnvType type) {
    switch (type) {
      case EnvType.dev:
        return 'dev';
      case EnvType.production:
        return 'production';
      default:
        return 'dev';
    }
  }
}

class Environments {
  String? kBaseUrl;

  Future getEnvironment() async {
    // SharedPreferencesUtilsImpl.setEnvironment(EnvTypeHelper.getValue(EnvType.nic));
    await SharedPreferencesUtilsImpl.getEnvironment();
    switch (EnvTypeHelper.getType(SharedPreferencesUtilsImpl.environment)) {
      case EnvType.dev:
        kBaseUrl = "";
        break;

      case EnvType.production:
        kBaseUrl = "";
        break;
    }
  }
}

// abstract class Api {
//   static const String kTimezones =
//       "https://api.timezonedb.com/v2.1/list-time-zone?key=WT3UPRMXNW7J&format=json";
// }

abstract class ApplicationURL {
  /// employee API Start
  static const String Nationalize = "https://api.nationalize.io/";
// End

}
