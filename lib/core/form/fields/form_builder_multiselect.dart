import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../../core/constants/entity_factory.dart';
import '../../form/fields_helper.dart';
import 'package:validators/validators.dart';

class FormBuilderMultiselect extends StatefulWidget {
  final String? attribute;
  final List<FormFieldValidator>? validators;
  final List<FilterEntityObject>? items;
  final dynamic initialValue;
  final bool? readOnly;
  final InputDecoration? decoration;
  final Function? onChanged;
  final AutovalidateMode? autovalidate;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextStyle? style;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final bool? autofocus;
  final bool? autocorrect;
  final bool? maxLengthEnforced;
  final int? maxLength;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double? cursorWidth;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets? scrollPadding;
  final bool? enableInteractiveSelection;
  final InputCounterWidgetBuilder? buildCounter;
  final bool? expands;
  final int? minLines;
  final bool? showCursor;
  final ValueTransformer? valueTransformer;

  FormBuilderMultiselect(
      {@required this.attribute,
      this.initialValue,
      this.items,
      this.validators = const [],
      this.readOnly = false,
      this.decoration = const InputDecoration(),
      this.autovalidate = AutovalidateMode.disabled,
      this.maxLines = 1,
      this.obscureText = false,
      this.textCapitalization = TextCapitalization.sentences,
      this.scrollPadding = const EdgeInsets.all(20.0),
      this.enabled = true,
      this.enableInteractiveSelection = true,
      this.maxLengthEnforced = true,
      this.textAlign = TextAlign.start,
      this.autofocus = false,
      this.autocorrect = true,
      this.cursorWidth = 2.0,
      this.keyboardType: TextInputType.text,
      this.style,
      this.controller,
      this.focusNode,
      this.textInputAction,
      this.strutStyle,
      this.textDirection,
      this.maxLength,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.inputFormatters,
      this.cursorRadius,
      this.cursorColor,
      this.keyboardAppearance,
      this.buildCounter,
      this.onChanged,
      this.expands = false,
      this.minLines,
      this.showCursor,
      this.valueTransformer});

  @override
  FormBuilderMultiselectState createState() => FormBuilderMultiselectState();
}

class FormBuilderMultiselectState extends State<FormBuilderMultiselect> {
  bool? _readOnly = false;
  TextEditingController? _effectiveController = new TextEditingController();
  final GlobalKey<FormFieldState>? _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState? _formState;
  String? _selectedIds;

  @override
  void initState() {
    super.initState();
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute!, _fieldKey!);

    if (widget.controller != null) {
      _effectiveController!.text = widget.controller!.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          List<MultiSelectDialogItem<int>>? _list = [];
          String? title;
          List<int>? _initialValue = [];
          if (widget.items != null && widget.items!.isNotEmpty) {
            widget.items!.forEach((i) {
              if (isNumeric(i.id!)) {
                _list.add(MultiSelectDialogItem(
                    int.tryParse(i.id!.toString()), i.name!));
              }
            });
          }

          if (widget.decoration != null) {
            title = widget.decoration!.labelText!;
          }
          if (widget.initialValue != null && widget.initialValue != '') {
            for (int i = 0; i < widget.initialValue!.length; i++) {
              // _initialValue.add(int.tryParse(widget.initialValue[i]));
              _initialValue.add(int.parse(widget.initialValue[i].toString()));
            }
          }
          dynamic selectedValues = await _showMultiSelect(
              context, title!, _list,
              initialValue: _initialValue);
          if (selectedValues != null) {
            String selected = selectedValues
                .toString()
                .substring(1, selectedValues.toString().length - 1);
            List<String> _selectedTemp = selected.split(',');
            String _txtSelected = '';
            setState(() {
              if (widget.items != null && widget.items!.isNotEmpty) {
                for (int i = 0; i < _selectedTemp.length; i++) {
                  widget.items!.forEach((j) {
                    if (j.id == _selectedTemp[i].trim()) {
                      _txtSelected = _txtSelected + j.name! + ',';
                    }
                  });
                }
              }
              if (_txtSelected != '' && _txtSelected.length > 0) {
                _txtSelected =
                    _txtSelected.substring(0, _txtSelected.length - 1);
              }
              _effectiveController!.text = _txtSelected;
              _selectedIds = selected;

              if (widget.onChanged != null) {
                widget.onChanged!(_txtSelected, selected);
              }
            });
          }
        } catch (e) {
          print(e);
        }
      },
      child: TextFormField(
        key: _fieldKey,
        validator: (val) {
          if (widget.validators != null) {
            for (int i = 0; i < widget.validators!.length; i++) {
              if (widget.validators![i](val) != null)
                return widget.validators![i](val);
            }
          }
          return null;
        },
        onSaved: (value) {
          if (widget.valueTransformer != null) {
            var transformed = widget.valueTransformer!(_selectedIds);
            _formState?.setAttributeValue(widget.attribute!, transformed);
          } else
            _formState?.setAttributeValue(widget.attribute!, _selectedIds);
        },
        enabled: false,
        style: widget.style,
        decoration: widget.decoration!.copyWith(
          enabled: !_readOnly!,
        ),
        autovalidateMode: widget.autovalidate ?? AutovalidateMode.disabled,
        // initialValue: "${_initialValue ?? ''}",
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText!,
        onEditingComplete: widget.onEditingComplete,
        controller: _effectiveController,
        autocorrect: widget.autocorrect!,
        autofocus: widget.autofocus!,
        buildCounter: widget.buildCounter,
        cursorColor: widget.cursorColor,
        cursorRadius: widget.cursorRadius,
        cursorWidth: widget.cursorWidth!,
        enableInteractiveSelection: widget.enableInteractiveSelection!,
        maxLength: widget.maxLength,
        inputFormatters: widget.inputFormatters,
        keyboardAppearance: widget.keyboardAppearance,
        maxLengthEnforced: widget.maxLengthEnforced!,
        onFieldSubmitted: widget.onFieldSubmitted,
        scrollPadding: widget.scrollPadding!,
        textAlign: widget.textAlign!,
        textCapitalization: widget.textCapitalization!,
        textDirection: widget.textDirection,
        textInputAction: widget.textInputAction,
        strutStyle: widget.strutStyle,
        readOnly: _readOnly!,
        expands: widget.expands!,
        minLines: widget.minLines,
        showCursor: widget.showCursor,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Future _showMultiSelect(BuildContext context, String? title,
    List<MultiSelectDialogItem<int>>? items,
    {List<int>? initialValue}) async {
  final selectedValues = await showDialog<Set<int>>(
    context: context,
    builder: (BuildContext context) {
      return MultiSelectDialog(
        title: title!,
        items: items!,
        initialSelectedValues:
            initialValue != null ? initialValue.toSet() : null,
      );
    },
  );
  return selectedValues;
}

class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(this.value, this.label);

  final V? value;
  final String? label;
}

class MultiSelectDialog<V> extends StatefulWidget {
  MultiSelectDialog(
      {Key? key, this.title, this.items, this.initialSelectedValues})
      : super(key: key);

  final List<MultiSelectDialogItem<V>>? items;
  final Set<V>? initialSelectedValues;
  final String? title;

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  final _selectedValues = Set<V>();

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues!);
    }
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title ?? 'Select'),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: ListTileTheme(
        contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
        child: SingleChildScrollView(
          child: ListBody(
            children: widget.items!.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL'),
          onPressed: _onCancelTap,
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: _onSubmitTap,
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label!),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value!, checked!),
    );
  }
}
