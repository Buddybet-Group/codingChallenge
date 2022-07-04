import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const HomePage(),
      duration: 5000,
      imageSize: 130,
      imageSrc: "assets/image/logo.png",
      text: "BuddyBet Coding Challenge \n Nationality Predicting",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Colors.white,
    );
  }
}