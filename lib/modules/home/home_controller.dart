import 'package:coding_chal/core/values/string_manager.dart';
import 'package:coding_chal/providers/repository/nations_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/api/country.dart';

/// Controller for [HomeScreen]
class HomeController extends GetxController {
  HomeController({NationsRepository? nationsRepository, StringManager? stringManager})
      : _nationsRepository = nationsRepository ?? Get.find<NationsRepository>(),
        _stringManager = stringManager ?? Get.find<StringManager>();

  final NationsRepository _nationsRepository;
  final StringManager _stringManager;

  /// Reactive variables and controllers
  bool fresh = true;
  TextEditingController textController = TextEditingController();
  Rx<Country> country = Country(countryId: '', probability: 0).obs;
  var errorTrigger = false.obs;

  /// triggers and functions
  search() async {
    Country? result = await _nationsRepository.getNationality(textController.text);
    if (result != null) {
      country.value = result;
    } else {
      errorTrigger.value = !errorTrigger.value;
    }
  }

  /// Text Providers
  String get hintText => _stringManager.nameInputHint;

  String get greetingText => _stringManager.greetingText;

  String get codingChallengeTitle => _stringManager.codingChallengeTitle;

  String get iGuessDescription => _stringManager.iGuessDescription;

  String get letsTryText => _stringManager.letsTryText;

  String get buttonTitle => _stringManager.findOutNowText;

  String get guessingText => _stringManager.guessingText;

  String get somethingWentWrongText => _stringManager.somethingWentWrongText;
}
