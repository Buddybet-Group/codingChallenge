import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../form/form_builder.dart';

class FormBuilderDropdown extends StatefulWidget {
  final String? attribute;
  final List<FormFieldValidator>? validators;
  final dynamic initialValue;
  final bool? readOnly;
  final InputDecoration? decoration;
  final ValueChanged? onChanged;
  final ValueTransformer? valueTransformer;

  final Widget? hint;
  final List<DropdownMenuItem>? items;
  final bool? isExpanded;
  final TextStyle? style;
  final bool? isDense;
  final int? elevation;
  final Widget? disabledHint;
  final double? iconSize;
  final Widget? underline;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;

  FormBuilderDropdown({
    @required this.attribute,
    @required this.items,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.isExpanded = true,
    this.isDense = false,
    this.elevation = 8,
    this.iconSize = 24.0,
    this.hint,
    this.initialValue,
    this.style,
    this.disabledHint,
    this.onChanged,
    this.valueTransformer,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
  });

  @override
  _FormBuilderDropdownState createState() => _FormBuilderDropdownState();
}

class _FormBuilderDropdownState extends State<FormBuilderDropdown> {
  bool _readOnly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  late FormBuilderState _formState;
  dynamic _initialValue;

  @override
  void initState() {
    _formState = FormBuilder.of(context)!;
    _formState.registerFieldKey(widget.attribute!, _fieldKey);

    if (widget.initialValue != null) {
      widget.items!.forEach((i) {
        if (i.value == widget.initialValue) {
          _initialValue = widget.initialValue;
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _formState.unregisterFieldKey(widget.attribute!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _readOnly = (_formState.readOnly == true) ? true : widget.readOnly!;
    return FormField(
      key: _fieldKey,
      enabled: !_readOnly,
      initialValue: _initialValue,
      validator: (val) {
       if(widget.validators != null){
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
          _formState.setAttributeValue(widget.attribute!, transformed);
        } else
          _formState.setAttributeValue(widget.attribute!, val);
      },
      builder: (FormFieldState<dynamic>? field) {
        return InputDecorator(
          decoration: widget.decoration!.copyWith(
            enabled: !_readOnly,
            errorText: field!.errorText,
          ),
          child: DropdownButton(
            isExpanded: widget.isExpanded!,
            // itemHeight: 56,
            hint: widget.hint,
            items: widget.items,
            value: field.value,
            style: widget.style,
            isDense: widget.isDense!,
            disabledHint: field.value != null && !_readOnly ? Text("${field.value.toString()}")
                : widget.disabledHint,
            elevation: widget.elevation!,
            iconSize: widget.iconSize!,
            icon: widget.icon,
            iconDisabledColor: widget.iconDisabledColor,
            iconEnabledColor: widget.iconEnabledColor,
            underline: widget.underline,
            onChanged: _readOnly ? (dynamic value) {}
            : (dynamic value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    field.didChange(value);

                    if (widget.onChanged != null) widget.onChanged!(value);
            },
            //TODO: add icon, enabledColor, disabledColor
            /*icon: widget.icon,
            iconEnabledColor: widget.iconEnabledColor,
            iconDisabledColor: widget.iconDisabledColor,*/
          ),
        );
      },
    );
  }
}
