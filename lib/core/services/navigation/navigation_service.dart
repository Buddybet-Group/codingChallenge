import 'package:flutter/widgets.dart' show GlobalKey, NavigatorState;
import 'package:flutter/material.dart';
import '../../../screens/Nationalize_Screen.dart';

/// Service that is responsible for navigating around the app
abstract class NavigationService {
  GlobalKey<NavigatorState> get navigatorKey;

  Future<dynamic> pushNamed(String routeName, {Object? arguments});

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments});

  Future<dynamic> popAllAndPushNamed(String routeName, {Object? arguments});

  void pop({dynamic returnValue});
}

abstract class Routes {
  static const String nationalizescreen = "/nationalizescreen";
}

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.nationalizescreen:
        return MaterialPageRoute(builder: (_) => NationalizeScreen());
    }
    return MaterialPageRoute(builder: (_) => NationalizeScreen());
  }
}
