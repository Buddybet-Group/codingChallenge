import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/constants/entity_factory.dart';
import '../../core/model/common.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesUtils {
  static const String BASE_URL = "BASE_URL";
  static const String NAME = "NAME";
  static const String Receiving_DATA = "Receiving_DATA";
  static const String CURRENT_THEME = "CURRENT_THEME";
  static const String CURRENT_LANG = "CURRENT_LANG";
  static const String CURRENT_ENV = "CURRENT_ENV";
}

class SharedPreferencesUtilsImpl extends SharedPreferencesUtils {
  static Locale? curr_language;
  static String? deepLink;
  static String? environment;
  static String? baseurl;
  static String? name;
  static NationalizeResponse? Nationalizedata;

  static void setDeepLink(String? link) {
    try {
      if (link != null) {
        if (link.contains('.com')) {
          deepLink = link.substring(link.indexOf('.com') + 5);
        }
      }
    } catch (e) {}
  }

  static Future<String> encrypt(dynamic data) async {
    return data;
    // CryptoGraphy encrypt = new CryptoGraphy();
    // return await encrypt.encryptData(data);
  }

  static Future<String> decrypt(dynamic data) async {
    return data;
    // CryptoGraphy decrypt = new CryptoGraphy();
    // return await decrypt.decryptData(data);
  }

  static Future<dynamic> clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    clearCache();
  }

  static Future<void> clearCache() async {
    try {
      final directory = await getExternalStorageDirectory();
      Directory path = Directory(directory!.path);
      path.deleteSync(recursive: true);
    } catch (e) {}
  }

  static Future<void> setDarkThemeEnabled(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPreferencesUtils.CURRENT_THEME, value);
  }

  static Future<bool> isDarkThemeEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferencesUtils.CURRENT_THEME) ?? false;
  }

  static Future<dynamic> remove(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }

  static Future<void> setLanguage(Locale language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    curr_language = language;
    Language _lang = Language(
      language_code: language.languageCode,
      country_code: language.countryCode,
    );
    prefs.setString(
        SharedPreferencesUtils.CURRENT_LANG, json.encode(_lang.toJson()));
  }

  static Future<Locale?> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _temp = prefs.getString(SharedPreferencesUtils.CURRENT_LANG);
    if (_temp != null) {
      Language _lang = Language.fromJson(json.decode(_temp));
      curr_language = Locale(_lang.language_code!, _lang.country_code);
      return curr_language;
    }
    return null;
  }

  static Future<void> setEnvironment(String value) async {
    environment = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPreferencesUtils.CURRENT_ENV, value);
  }

  static Future<String?> getEnvironment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    environment = prefs.getString(SharedPreferencesUtils.CURRENT_ENV);
    return environment;
  }

  /// start
  static Future<void> setName(String value) async {
    name = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPreferencesUtils.NAME, value);
  }

  static Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString(SharedPreferencesUtils.NAME);
    return name;
  }

  ///
  // static Future<void> setLoginData(ReceivingResponse loginuser) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   logindata = loginuser;
  //   prefs.setString(
  //       SharedPreferencesUtils.LOGIN_DATA, json.encode(loginuser.toJson()));
  // }
  //
  // static Future<LoginResponse?> getLoginData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString(SharedPreferencesUtils.LOGIN_DATA) != null) {
  //     // print(prefs.getString(SharedPreferencesUtils.LOGIN_DATA));
  //     logindata = LoginResponse.fromJson(
  //         json.decode(prefs.getString(SharedPreferencesUtils.LOGIN_DATA)!));
  //     return logindata;
  //   }
  //   return LoginResponse();
  // }
}
