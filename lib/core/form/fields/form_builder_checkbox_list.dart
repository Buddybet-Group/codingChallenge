import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../core/constants/entity_factory.dart';
import '../../form/fields_helper.dart';

class FormBuilderCheckboxList extends StatefulWidget {
  final String? attribute;
  final List<FormFieldValidator>? validators;
  final dynamic initialValue;
  final bool? readOnly;
  final InputDecoration? decoration;
  final ValueChanged? onChanged;
  final ValueTransformer? valueTransformer;

  final List<FormBuilderFieldOption>? options;
  final bool? leadingInput;
  final Color? activeColor;
  final Color? checkColor;
  final MaterialTapTargetSize? materialTapTargetSize;
  final bool? tristate;

  FormBuilderCheckboxList({
    @required this.attribute,
    @required this.options,
    this.initialValue = const [],
    this.validators = const [],
    this.readOnly = false,
    this.leadingInput = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.activeColor,
    this.checkColor,
    this.materialTapTargetSize,
    this.tristate = false,
  });

  @override
  _FormBuilderCheckboxListState createState() =>
      _FormBuilderCheckboxListState();
}

class _FormBuilderCheckboxListState extends State<FormBuilderCheckboxList> {
  bool _readOnly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState? _formState;
  dynamic _initialValue;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute!, _fieldKey);
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

  Widget _checkbox(FormFieldState<dynamic> field, int i) {
    return Checkbox(
      activeColor: widget.activeColor,
      checkColor: widget.checkColor,
      materialTapTargetSize: widget.materialTapTargetSize,
      tristate: widget.tristate!,
      value: field.value.contains(widget.options![i].value),
      onChanged: _readOnly
          ? null
          : (bool? value) {
              FocusScope.of(context).requestFocus(FocusNode());
              var currValue = field.value;
              if (widget.options!.length == 1) {
                if (value!)
                  currValue = widget.options![i].value;
                else
                  currValue = '0';
              } else {
                if (value!)
                  currValue.add(widget.options![i].value);
                else
                  currValue.remove(widget.options![i].value);
              }
              field.didChange(currValue);
              if (widget.onChanged != null) widget.onChanged!(currValue);
            },
    );
  }

  Widget _leading(FormFieldState<dynamic> field, int i) {
    if (widget.leadingInput!) return _checkbox(field, i);
    return Container();
  }

  Widget _trailing(FormFieldState<dynamic> field, int i) {
    if (!widget.leadingInput!) return _checkbox(field, i);
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    _readOnly = ((_formState?.readOnly == true) ? true : widget.readOnly)!;

    return FormField(
        key: _fieldKey,
        enabled: !_readOnly,
        initialValue: _initialValue ?? [],
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
          List<Widget> checkboxList = [];
          for (int i = 0; i < widget.options!.length; i++) {
            checkboxList.addAll([
              ListTile(
                dense: true,
                isThreeLine: false,
                contentPadding: EdgeInsets.all(0.0),
                leading: _leading(field, i),
                trailing: _trailing(field, i),
                title: Text(
                  "${widget.options![i].label ?? widget.options![i].value}",
                  style: AppStyles.customFontCalibri(context, fontSize: 14),
                ),
                onTap: _readOnly
                    ? null
                    : () {
                        var currentValue = field.value;
                        if (widget.options!.length == 1) {
                          if (!currentValue.contains(widget.options![i].value))
                            currentValue = widget.options![i].value;
                          else
                            currentValue = '0';
                          field.didChange(currentValue);
                        } else {
                          if (!currentValue.contains(widget.options![i].value))
                            currentValue.add(widget.options![i].value);
                          else
                            currentValue.remove(widget.options![i].value);
                          field.didChange(currentValue);
                        }
                        if (widget.onChanged != null)
                          widget.onChanged!(currentValue);
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
              enabled: !_readOnly,
              errorText: field.errorText,
              contentPadding: EdgeInsets.only(top: 10.0),
            ),
            child: Column(
              children: checkboxList,
            ),
          );
        });
  }
}
