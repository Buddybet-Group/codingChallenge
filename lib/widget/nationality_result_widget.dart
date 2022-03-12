import 'package:flutter/material.dart';

class NationalityResultWidget extends StatelessWidget {
  final String nationality;
  final Color color;
  final double fontSize;

  const NationalityResultWidget(this.nationality, this.color, this.fontSize, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Nationality: $nationality',
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }
}
