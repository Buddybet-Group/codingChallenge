import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String message;

  const ErrorMessageWidget(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
    );
  }
}
