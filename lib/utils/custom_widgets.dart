import 'package:flutter/material.dart';

import 'app.dart';

///displays the error snackbar with the given [message]
void showErrorSnackBar(String message) {
  ScaffoldMessenger.of(App.context!).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 4),
      elevation: 5.0,
      content: formFieldLabel(label: message, fontSize: 16),
      backgroundColor: Colors.red,
    ),
  );
}

Widget formFieldLabel(
    {required String label,
    double? fontSize,
    Color color = Colors.white,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.center,
    bool isUnderline = false}) {
  return Text(
    label,
    textAlign: textAlign,
    style: TextStyle(
      fontWeight: fontWeight,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      color: color,
    ),
    softWrap: true,
    maxLines: 2,
  );
}
