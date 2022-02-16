import 'package:catcher/core/catcher.dart';
import 'package:catcher/mode/dialog_report_mode.dart';
import 'package:catcher/model/catcher_options.dart';
import 'package:coding_chal/core/configurations/dev_configuration.dart';
import 'package:coding_chal/core/values/string_manager.dart';
import 'package:flutter/material.dart';

import 'core/values/environment.dart';
import 'modules/buddy_bet_challenge.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final CatcherOptions options = CatcherOptions(DialogReportMode(), []);

  /// Catcher displays errors in a popup
  Catcher(
    runAppFunction: () => runApp(
      setupApp(
        configuration: const DevConfiguration(),
        stringManager: const StringManager(),
        environment: Environment.dev,
      ),
    ),
    debugConfig: options,
    profileConfig: options,
    releaseConfig: options,
    ensureInitialized: true,
  );
}
