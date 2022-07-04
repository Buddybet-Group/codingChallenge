import 'package:flutter/material.dart';

class CommonProgressBar extends StatelessWidget {
  const CommonProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class CommonEmptyInit extends StatelessWidget {
  const CommonEmptyInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

}