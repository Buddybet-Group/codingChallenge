import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../../core/constants/constants.dart';
import '../../../core/constants/entity_factory.dart';
import '../../../core/constants/shared_preferences_utils_impl.dart';
import '../../../core/services/base_list_provider.dart';
import '../../../core/services/http_services.dart';
import '../../../core/services/locator.dart';
import '../../../core/services/navigation/navigation_service.dart';

import '../model/common.dart';

class StartUpViewModel extends BaseListProvider {
  late HttpService httpService;
  Environments env = Environments();
  final NavigationService? navigationService = locator<NavigationService>();

  StartUpViewModel() {
    httpService = new HttpService();
    env.getEnvironment();
  }

  Future<void> getLanguage() async {
    try {
      Locale? _lang = await SharedPreferencesUtilsImpl.getLanguage();
      if (_lang != null) {
        setLanguage(_lang.languageCode);
      }
    } catch (e) {
      print(e);
    }
  }

  void changeTheme(BuildContext context, bool isDark) {
    try {
      SystemChrome.setSystemUIOverlayStyle(
          isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light);
      SharedPreferencesUtilsImpl.setDarkThemeEnabled(isDark);
      setThemeStatus(isDark);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getTheme() async {
    bool isDarkTheme = await SharedPreferencesUtilsImpl.isDarkThemeEnabled();
    setThemeStatus(isDarkTheme);
  }

  Future<void> getNationalizeName(
      Map<String, dynamic> receivingParams, BuildContext context) async {
    setStateType(StateType.loading);
    try {
      await httpService.request(
          queryParams: receivingParams,
          url: ApplicationURL.Nationalize + "?name=" + receivingParams["name"],
          method: Method.get,
          onSuccess: (data) {
            NationalizeResponse response = NationalizeResponse.fromJson(data);
            // print("Nationalize Response ==>" + response.toJson().toString());
            if (response.name != null && response.name != "null") {
              setNationalizeResponse(response);
            } else {
              setNationalizeResponse(response);
            }
          });
      setStateType(StateType.Success);
    } on Exception {
      setStateType(StateType.error);
    }
  }
}
