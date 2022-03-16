import 'dart:async';
import 'package:coding_chal/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'di/service_locator.dart';
import 'stores/country/country_store.dart';
import 'ui/home/search_user_screen.dart';

void main() {
  runZonedGuarded(() async {
    await setupLocator();
    WidgetsFlutterBinding.ensureInitialized();
    runApp(App());
  }, (Object error, StackTrace stack) {
    debugPrint(error.toString());
    debugPrintStack(stackTrace: stack);
  });
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final CountryStore _countryStore = CountryStore(getIt<Repository>());    

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CountryStore>(create: (_) => _countryStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return const MaterialApp(
            home: SearchUserScreen(), // calling main screen:
          );
        },
      ),
    );
  }
}
