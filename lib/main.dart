import 'package:coding_chal/services/locator.dart';
import 'package:coding_chal/ui/shared/styles.dart';
import 'package:coding_chal/ui/splash/splash_view.dart';
import 'package:flutter/material.dart';

void main() async {
  await SetLocator();
  runApp(
      MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: appColore5e6eb,
          ),
          debugShowCheckedModeBanner: false,
        home: SplashView()
  ));
}

