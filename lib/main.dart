import 'package:coding_chal/routes/routes.dart';
import 'package:coding_chal/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  final RouteGenerator routeGenerator = RouteGenerator();
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routeGenerator.generateRoute,
      home: HomePage()));
}
