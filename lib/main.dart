import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';

import 'src/app/pages/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CountryCodes.init();
  runApp(const MaterialApp(home: HomeScreen()));
}
