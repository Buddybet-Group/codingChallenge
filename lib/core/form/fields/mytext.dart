import '../../../core/constants/entity_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyText extends StatefulWidget {
  final Key? formKey;
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
  final String? counterText;
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

  MyText({
    this.formKey,
    this.initialValue,
    this.focusNode,
    this.decoration = const InputDecoration(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    ),
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
    this.counterText,
    this.helperText,
    this.hintText,
    this.hintStyle,
  });

  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
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
    return TextFormField(
      // key: widget.formKey,
      controller: widget.controller,
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      // decoration: widget.decoration,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: widget.style,
      textAlign: widget.textAlign!,
      autofocus: widget.autofocus!,
      obscureText: widget.obscureText!,
      autocorrect: widget.autocorrect!,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onChanged: (v) {
        if (widget.onChanged != null) {
          widget.onChanged!(v);
        }
      },
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: widget.labelStyle,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        counterText: widget.counterText,
        helperText: widget.helperText,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      validator: widget.validators,
      enabled: widget.enabled,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding!,
      inputFormatters: <TextInputFormatter>[
        // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
    );
  }
}
