import 'package:coding_chal/ui/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: MainView(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/images/logo.png",
      text: "Coding Challenge",
      textType: TextType.NormalText,
      textStyle: const TextStyle(
        fontSize: 20.0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
