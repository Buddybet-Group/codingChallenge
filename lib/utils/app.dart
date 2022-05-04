import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class App {
  static GlobalKey<NavigatorState> navigatorState = GlobalKey();

  ///gets the application [context]
  static BuildContext? get context => App.navigatorState.currentContext;

  ///gets the device [devicePixelRatio] of the window
  static double get pixelRatio => ui.window.devicePixelRatio;

  ///gets the size of the window
  static Size get size => ui.window.physicalSize / pixelRatio;

  ///pops the screen from the stack
  static void pop() => Navigator.of(context!).pop();
}
