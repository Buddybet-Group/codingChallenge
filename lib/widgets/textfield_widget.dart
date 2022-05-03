import 'package:coding_chal/theme/string_resources.dart';
import 'package:flutter/material.dart';

class NameTextFieldWidget extends StatelessWidget {
  final Key _key;
  final TextEditingController _controller;
  final FocusNode _focusNode;
  final ValueChanged<String>? onChange;

  const NameTextFieldWidget(this._key, this._controller, this._focusNode, {required this.onChange})
      : super(key: _key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _key,
      scrollPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
      controller: _controller,
      focusNode: _focusNode,
      onChanged: onChange,
      decoration: InputDecoration(
          hintText: StringResources.enterYourName,
          hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey.withOpacity(0.8))),
      onFieldSubmitted: (String value) {
        FocusManager.instance.primaryFocus?.unfocus();
        onChange!(value);
      },
    );
  }
}
