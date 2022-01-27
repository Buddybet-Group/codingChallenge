import 'package:coding_chal/services/locator.dart';
import 'package:flutter/material.dart';

import 'views/dashboard_view.dart';

void main() async{
    await SetUpLocator();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashBoardView()
      )
    );
}
