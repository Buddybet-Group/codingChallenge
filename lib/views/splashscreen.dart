
import 'package:buddybet_assignment/views/landing_page.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/colors.dart';


class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  EasySplashScreen(
      logo: Image.asset(
          'assets/logo.png'),
      backgroundColor: white,
      showLoader: true,
      logoSize: Get.height * 0.1,
      loaderColor: green,
      loadingText: Text("Loading...",style:TextStyle(
        fontFamily: 'sans-serif-medium',
        color: logoclr,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        letterSpacing: 0,
      )),
      navigator: LandingPage(),
      durationInSeconds: 2,
    );
  }


}
