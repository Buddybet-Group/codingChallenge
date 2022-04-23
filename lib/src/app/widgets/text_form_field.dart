import 'package:flutter/material.dart';

class SearchTextFromField extends StatelessWidget {
  final bool? password;
  final String? hintText;
  final double? height;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  final GestureTapCallback? onTapTextField;
  final ValueChanged<String>? onChanged;

  const SearchTextFromField({
    Key? key,
    this.hintText,
    this.height,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.password,
    this.controller,
    this.validator,
    required this.focusNode,
    required this.onFieldSubmitted,
    this.onTapTextField,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2));
    return SizedBox(
      height: height,
      child: TextFormField(
        onTap: onTapTextField,
        obscureText: password ?? false,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, right: 10),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintStyle: const TextStyle(letterSpacing: 0.3, color: Colors.grey),
          disabledBorder: inputBorder,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
        ),
        textInputAction: TextInputAction.done,
        keyboardType: inputType,
        controller: controller,
        validator: validator,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}

class NoBorderTextFromField extends StatelessWidget {
  final bool? password;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;

  const NoBorderTextFromField({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.password,
    this.controller,
    this.validator,
    required this.focusNode,
    required this.onFieldSubmitted,
  }) : super(key: key);

  final inputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1),
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20),
      topLeft: Radius.circular(20),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: password ?? false,
      decoration: InputDecoration(
        focusColor: Colors.white,
        hintText: hintText,
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.all(8.0),
        suffixIcon: suffixIcon,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        errorBorder: inputBorder,
        disabledBorder: inputBorder,
      ),
      keyboardType: inputType,
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
