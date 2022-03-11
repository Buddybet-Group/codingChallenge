import 'package:flutter/material.dart';

class ThemeAndroid {
  static ThemeData light = ThemeData(
    platform: TargetPlatform.android,
    brightness: Brightness.light,
    primaryColor: Color(0xffFC0F07),
    primaryColorLight: Colors.purple[400],
    primaryColorDark: Colors.grey,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.blue, size: 20),
  );

  static ThemeData dark = ThemeData(
      platform: TargetPlatform.android,
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple[200],
      primaryColorLight: Colors.purple[200],
      primaryColorDark: Colors.white,
      backgroundColor: Colors.grey,
      iconTheme: IconThemeData(color: Colors.white, size: 20));
}

class ThemeIOS {
  static ThemeData light =
      ThemeData(platform: TargetPlatform.iOS, brightness: Brightness.light);

  static ThemeData dark =
      ThemeData(platform: TargetPlatform.iOS, brightness: Brightness.dark);
}
