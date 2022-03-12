import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.hintText,
    this.inputFormatters,
    this.validator,
    this.controller,
    this.onChange,
    this.maxLength = 20,
  }) : super(key: key);
  final String hintText;
  final int maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        onChanged: onChange,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
