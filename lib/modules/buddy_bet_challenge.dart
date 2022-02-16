import 'package:coding_chal/core/configurations/configuration.dart';
import 'package:coding_chal/core/utils/injection.dart';
import 'package:coding_chal/core/values/environment.dart';
import 'package:coding_chal/core/values/string_manager.dart';
import 'package:coding_chal/modules/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

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

  return GetMaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text(
          stringManager.appBarTitle,
        ),
      ),
      body: const HomeScreen(),
    ),
  );
}
