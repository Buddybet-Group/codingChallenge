import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class App {
  static GlobalKey<NavigatorState> navigatorState = GlobalKey();

  ///gets the application [context]
  static BuildContext? get context => App.navigatorState.currentContext;

  ///gets the Applocalization values
  // static final localeStrings = AppLocalizations.of(context!);

  ///gets the Applocalization values

  /// give access to Theme.of(context)
  static ThemeData get theme {
    var _theme = ThemeData.fallback();
    if (context != null) {
      _theme = Theme.of(context!);
    }
    return _theme;
  }

  ///gets the device [devicePixelRatio] of the window
  static double get pixelRatio => ui.window.devicePixelRatio;

  ///gets the size of the window
  static Size get size => ui.window.physicalSize / pixelRatio;

  ///gets the [textTheme] of the application
  static TextTheme get textTheme => theme.textTheme;
  //static NavigatorState get navigator => Navigator.of(context);

  ///pushes the specified screen to the stack
  ///[page] screen to be pushed
  static Future<dynamic> push(Widget page) => Navigator.of(context!)
      .push(MaterialPageRoute(builder: (context) => page));

  ///pushes the specified screen and
  ///removes all the other screens from stack
  ///[page] Screen to be pushed
  static Future<dynamic> pushAndRemoveUntil(Widget page) =>
      Navigator.of(context!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => page),
          (Route<dynamic> route) => false);

  ///pops the screen from the stack
  static void pop() => Navigator.of(context!).pop();

  ///gets the screen width
  static double get screenWidth => MediaQuery.of(context!).size.width;

  ///gets the screen height
  static double get screenHeight => MediaQuery.of(context!).size.height;

  ///checks checkValidSONumber starts with 70
  ///takes [text] as a string parameter
  ///returns boolean value
  static bool checkValidSONumberForMea(String text) {
    bool validSO = false;
    if (text.startsWith(r'40') || text.startsWith(r'70')) validSO = true;
    return validSO;
  }

  ///checks checkValidSONumber starts with 70
  ///takes [text] as a string parameter
  ///returns boolean value
  static bool checkValidSONumberForOOW(String text) {
    bool validSO = false;
    if (text.startsWith(r'20')) validSO = true;
    return validSO;
  }

  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
