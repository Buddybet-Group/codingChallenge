import 'package:coding_chal/core/configurations/configuration.dart';
import 'package:coding_chal/core/theme/main_theme.dart';
import 'package:coding_chal/core/utils/injection.dart';
import 'package:coding_chal/core/values/assets.dart';
import 'package:coding_chal/core/values/environment.dart';
import 'package:coding_chal/core/values/string_manager.dart';
import 'package:flutter/material.dart';

/// Root of BuddyBet App.
Widget setupApp({
  required Configuration configuration,
  required StringManager stringManager,
  required Environment environment,
}) {
  setupInjection(
    configuration: configuration,
    stringManager: stringManager,
    environment: environment,
  );

  return MaterialApp(
    theme: ThemeData.light().copyWith(
      textTheme: MainTheme().defaultTextTheme(),
    ),
    home: Scaffold(
      body: Container(
        color: Colors.red,
      ),
    ),
  );
}
