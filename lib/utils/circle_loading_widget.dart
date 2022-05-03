import 'package:coding_chal/theme/string_resources.dart';
import 'package:flutter/material.dart';

class CircleLoadingWidget extends StatelessWidget {
  const CircleLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 32.0, height: 32.0, child: CircularProgressIndicator()),
        const SizedBox(width: 16.0),
        Text(
          StringResources.pleaseWait,
          style: TextStyle(fontSize: 16.0, color: Colors.grey.withOpacity(0.9)),
        )
      ],
    );
  }
}
