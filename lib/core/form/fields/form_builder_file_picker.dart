import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../../core/services/utils.dart';
import '../../../core/constants/entity_factory.dart';
import '../../form/form_builder.dart';

class FormBuilderFilePicker extends StatefulWidget {
  final String? attribute;
  final List<FormFieldValidator>? validators;
  final String? initialValue;
  final bool? readOnly;
  final InputDecoration? decoration;
  final Function? onChanged;
  final ValueTransformer? valueTransformer;

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

  FormBuilderFilePicker({
    @required this.attribute,
    this.initialValue,
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
    this.valueTransformer,
    this.expands = false,
    this.minLines,
    this.showCursor,
  });

  @override
  FormBuilderFilePickerState createState() => FormBuilderFilePickerState();
}

class FormBuilderFilePickerState extends State<FormBuilderFilePicker> {
  bool? _readOnly = false, _close = false;
  TextEditingController? _effectiveController;
  FormBuilderState? _formState;
  final GlobalKey<FormFieldState>? _fieldKey = GlobalKey<FormFieldState>();
  String? _initialValue;
  File? _file;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute!, _fieldKey!);
    _initialValue = widget.initialValue ??
        (_formState!.initialValue.containsKey(widget.attribute)
            ? _formState!.initialValue[widget.attribute]
            : null);
    if (widget.controller != null) {
      _effectiveController = widget.controller;
    } else {
      if (_initialValue != null && _initialValue!.length > 1) {
        _effectiveController = TextEditingController(
          text: "${_initialValue!.substring(1)}",
        );
      } else {
        _effectiveController = TextEditingController(
          text: "${_initialValue ?? ''}",
        );
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _readOnly = (_formState?.readOnly == true) ? true : widget.readOnly;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        // textAlignVertical: TextAlignVertical.center,
        key: _fieldKey,
        onTap: () async {
          try {
            if (!_close! && _file == null) {
              // _file = (await AppUtils.getFile()) as File?;
              //  setState(() {
              //    if(widget.onChanged != null && _file != null){
              //      var filename = _file!.path.substring(_file!.path.indexOf('file_picker') + 12);
              //      _effectiveController!.text = _file!.path;
              //      // var filenam = filename;
              //      widget.onChanged!(_file!.path, _file!.path);
              //      _close = true;
              //    }
              //  });
            } else {
              _close = false;
            }
          } catch (e) {
            print(e);
          }
        },
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
          if (_file != null) {
            val = _file!.path;
          }
          if (widget.valueTransformer != null) {
            var transformed = widget.valueTransformer!(val);
            _formState?.setAttributeValue(widget.attribute!, transformed);
          } else
            _formState?.setAttributeValue(widget.attribute!, val);
        },
        enabled: !_readOnly!,
        style: widget.style,
        focusNode: _readOnly! ? AlwaysDisabledFocusNode() : widget.focusNode,
        decoration: widget.decoration!.copyWith(
            enabled: !_readOnly!,
            suffixIcon: _file != null
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _file = null;
                        _effectiveController!.clear();
                        _close = true;
                      });
                    },
                  )
                : null),
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
        readOnly: true,
        expands: widget.expands!,
        minLines: widget.minLines,
        showCursor: widget.showCursor,
      ),
    );
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute!);
    _effectiveController!.dispose();
    super.dispose();
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
