import '../../../core/constants/entity_factory.dart';
import '../../../core/form/form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyCustomText extends StatefulWidget {
  final Key? formKey;
  final String text;

  final String? initialValue;
  final String? attribute;
  final String? label;
  final FieldTypes? type;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextAlign? textAlign;
  final bool? autofocus;
  final bool? obscureText;
  final bool? autocorrect;
  final bool? autovalidate;
  final bool? maxLengthEnforced;
  final int? maxLines;
  final int? maxLength;
  final String? helperText;
  final hintText;
  final hintStyle;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator? validators;
  final bool? enabled;
  final InputDecoration? decorations;
  final Brightness? keyboardAppearance;
  final EdgeInsets? scrollPadding;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController? controller;

  MyCustomText({
    this.formKey,
    required this.text,
    this.initialValue,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.style,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.autovalidate = false,
    this.maxLengthEnforced = true,
    this.maxLines = 1,
    this.maxLength,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validators,
    this.enabled,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.onChanged,
    this.inputFormatter,
    this.controller,
    this.attribute,
    this.type,
    this.label,
    this.labelStyle,
    this.decorations,
    this.helperText,
    this.hintText,
    this.hintStyle,
  });

  @override
  _MyCustomTextState createState() => _MyCustomTextState();
}

class _MyCustomTextState extends State<MyCustomText> {
  // final TextEditingController _controller = new TextEditingController();

  // _onChangedValue() {
  //   if (widget.onChanged != null) {
  //     widget.onChanged!(widget.controller);
  //   }
  // }
  //
  // @override
  // void initState() {
  //   _controller.addListener(_onChangedValue);
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _controller.removeListener(_onChangedValue);
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: widget.style,
    );
  }
}
