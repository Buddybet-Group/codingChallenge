import 'package:flutter/material.dart';
import '../views/screens/home_page.dart';
import 'route_names.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final Object? args = settings.arguments;

    return MaterialPageRoute(
      settings: settings,
      builder: (_) {
        switch (settings.name) {
          case RouteNames.homePage:
            return HomePage();
          default:
            return Container(
              child: const Center(child: Text('No Routes')),
            );
        }
      },
    );
  }
}
