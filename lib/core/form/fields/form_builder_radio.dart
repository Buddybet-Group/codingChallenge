import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../core/constants/entity_factory.dart';
import '../../form/form_builder.dart';

class FormBuilderRadio extends StatefulWidget {
  final String? attribute;
  final List<FormFieldValidator>? validators;
  final dynamic initialValue;
  final bool? readOnly;
  final InputDecoration? decoration;
  final ValueChanged? onChanged;
  final ValueTransformer? valueTransformer;
  final bool? leadingInput;

  final List<FormBuilderFieldOption>? options;

  final MaterialTapTargetSize? materialTapTargetSize;

  final Color? activeColor;

  FormBuilderRadio({
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.leadingInput = false,
    this.materialTapTargetSize,
    this.activeColor,
  });

  @override
  _FormBuilderRadioState createState() => _FormBuilderRadioState();
}

class _FormBuilderRadioState extends State<FormBuilderRadio> {
  bool? _readOnly = false;
  final GlobalKey<FormFieldState>? _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState? _formState;
  dynamic _initialValue;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute!, _fieldKey!);
    _initialValue = widget.initialValue ??
        (_formState!.initialValue.containsKey(widget.attribute)
            ? _formState!.initialValue[widget.attribute]
            : null);
    super.initState();
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute!);
    super.dispose();
  }

  Widget _radio(FormFieldState<dynamic> field, int i) {
    return Radio<dynamic>(
      value: widget.options![i].value,
      groupValue: field.value,
      materialTapTargetSize: widget.materialTapTargetSize,
      activeColor: widget.activeColor,
      onChanged: _readOnly!
          ? null
          : (dynamic value) {
              FocusScope.of(context).requestFocus(FocusNode());
              field.didChange(value);
              if (widget.onChanged != null) widget.onChanged!(value);
            },
    );
  }

  Widget? _leading(FormFieldState<dynamic> field, int i) {
    if (widget.leadingInput!) return _radio(field, i);
    return null;
  }

  Widget? _trailing(FormFieldState<dynamic> field, int i) {
    if (!widget.leadingInput!) return _radio(field, i);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _readOnly = (_formState?.readOnly == true) ? true : widget.readOnly;

    return FormField(
      key: _fieldKey,
      enabled: !_readOnly!,
      initialValue: _initialValue,
      validator: (val) {
        if (widget.validators != null) {
          for (int i = 0; i < widget.validators!.length; i++) {
            if (widget.validators![i](val) != null)
              return widget.validators![i](val);
          }
        }
        return null;
      },
      onSaved: (val) {
        if (widget.valueTransformer != null) {
          var transformed = widget.valueTransformer!(val);
          _formState?.setAttributeValue(widget.attribute!, transformed);
        } else
          _formState?.setAttributeValue(widget.attribute!, val);
      },
      builder: (FormFieldState<dynamic> field) {
        List<Widget> radioList = [];
        for (int i = 0; i < widget.options!.length; i++) {
          radioList.addAll([
            ListTile(
              dense: true,
              isThreeLine: false,
              contentPadding: EdgeInsets.all(0.0),
              leading: _leading(field, i),
              title: Text(
                "${widget.options![i].label ?? widget.options![i].value}",
                style: AppStyles.customFontCalibri(context, fontSize: 14),
              ),
              trailing: _trailing(field, i),
              onTap: _readOnly!
                  ? null
                  : () {
                      field.didChange(widget.options![i].value);
                      if (widget.onChanged != null)
                        widget.onChanged!(widget.options![i].value);
                    },
            ),
            (i == (widget.options!.length - 1))
                ? Container()
                : Divider(
                    height: 0.0,
                  ),
          ]);
        }
        return InputDecorator(
          decoration: widget.decoration!.copyWith(
            enabled: !_readOnly!,
            errorText: field.errorText,
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0, left: 10),
            // border: InputBorder.none,
          ),
          child: Column(
            children: radioList,
          ),
        );
      },
    );
  }
}
