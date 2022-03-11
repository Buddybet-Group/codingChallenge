import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/entity_factory.dart';
import '../form/fields/form_builder_file_picker.dart';
import '../form/fields_helper.dart';
import 'package:intl/intl.dart';
import '../form/form_builder.dart';

class FieldBuilder<T> extends StatefulWidget {
  const FieldBuilder({
    Key? key,
    this.controller,
    this.formKey,
    this.index,
    this.autoFocus: false,
    @required this.type,
    this.defaultValue,
    this.values,
    this.attribute,
    this.label,
    this.prefix,
    this.onChanged,
    this.maxLines: 4,
    this.enable: true,
    this.visibility: true,
    this.onFieldDisable,
    this.onFieldHide,
    this.validators,
    this.lastDate,
    this.labelStyle,
    this.onFilePicked,
    this.maxLength,
    this.maxLengthEnforced: false,
    this.obscureText: false,
    this.keyboardType,
    this.textAlign: TextAlign.start,
    this.hintText,
    this.counterText,
    this.hintStyle,
    this.autofocus: true,
    this.autovalidate: AutovalidateMode.disabled,
    this.helperText,
    this.initialTime,
    this.prefixIcon,
    this.surefixIcon,
    this.onSaved,
    this.decoration,
    this.decorations = const InputDecoration(),
    this.style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: "Open Sans"),
    this.contentpadding: const EdgeInsets.only(left: 0.0, top: 20, bottom: 20),
    this.inputFormatter: const <TextInputFormatter>[],
    this.focusNode,
    this.textInputAction: TextInputAction.done,
    this.TextIcon: null,
  }) : super(key: key);

  final TextEditingController? controller;
  final InputDecoration? decorations;
  final GlobalKey<FormBuilderState>? formKey;
  final List<TextInputFormatter>? inputFormatter;
  final int? index;
  final bool? autoFocus;
  final TimeOfDay? initialTime;
  final Icon? prefixIcon;
  final IconButton? surefixIcon;
  final FieldTypes? type;
  final T? defaultValue;
  final List? values;
  final String? label;
  final String? counterText;
  final String? helperText;
  final String? prefix;
  final String? attribute;
  final int? maxLines;
  final Function? onChanged;
  final bool? enable;
  final bool? autofocus;
  final AutovalidateMode? autovalidate;
  final bool? visibility;
  final Function? onFieldDisable;
  final Function? onFieldHide;
  final List<FormFieldValidator>? validators;
  final DateTime? lastDate;
  final TextStyle? labelStyle;
  final Function? onFilePicked;
  final int? maxLength;
  final bool? maxLengthEnforced;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final TextStyle? style;
  final Decoration? decoration;
  final EdgeInsetsGeometry? contentpadding;
  final hintText;
  final hintStyle;
  final FormFieldSetter<String>? onSaved;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Icon? TextIcon;

  // final FormFieldSetter<String>? onSaved;

  @override
  _FieldBuilderState createState() => _FieldBuilderState();
}

class _FieldBuilderState extends State<FieldBuilder> {
  List? _values = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.visibility!
        ? Container(
            child: Column(
              children: <Widget>[
                _fields(context)!,
                // Gaps.vGap(10),
              ],
            ),
          )
        : Gaps.empty;
  }

  Widget? _fields(context) {
    switch (widget.type) {
      case FieldTypes.DROPDOWN:
        _dropDownValue();
        return FormBuilderDropdown(
          attribute: widget.attribute,
          decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: widget.labelStyle,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              counterText: widget.counterText,
              helperText: widget.helperText),
          underline: Gaps.empty,
          style: AppStyles.customFontCalibri(context,
              fontSize: 16, color: ColorConstant.darkColor),
          isDense: true,
          readOnly: !widget.enable!,
          initialValue: widget.defaultValue,
          items: _values!
              .map((option) => DropdownMenuItem(
                    child: Text(option.name),
                    value: option.id,
                  ))
              .toList(),
          validators: widget.validators,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
        );

      case FieldTypes.MULTIPLEDROPDOWN:
        List<FilterEntityObject> _val = [];
        widget.values!.forEach((option) {
          _val.add(FilterEntityObject(id: option.id, name: option.name));
        });

        return FormBuilderMultiselect(
          attribute: widget.attribute,
          controller: widget.controller,
          textAlign: widget.textAlign,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: widget.labelStyle,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            counterText: widget.counterText,
            helperText: widget.helperText,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.darkColor54),
            ),
          ),
          initialValue: widget.defaultValue,
          style: AppStyles.customFontCalibri(context),
          readOnly: !widget.enable!,
          validators: widget.validators,
          items: _val,
          onChanged: (values, ids) {
            if (widget.onChanged != null) widget.onChanged!(values, ids);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(ids.toString(), widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(ids.toString(), widget.index);
          },
        );

      case FieldTypes.AUTOCOMPLETE:
        return TextFormField(
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            labelText: widget.label,
            labelStyle: widget.labelStyle,
            counterText: widget.counterText,
            helperText: widget.helperText,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.darkColor54),
            ),
          ),
        );

      case FieldTypes.DATETIMEPICKER:
        return FormBuilderDateTimePicker(
          autofocus: widget.autoFocus,
          attribute: widget.attribute,
          controller: widget.controller,
          textAlign: widget.textAlign,
          enabled: widget.enable,
          inputType: InputType.both,
          format: DateFormat("yyyy-MM-dd h:mma"),
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: widget.labelStyle,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            counterText: widget.counterText,
            helperText: widget.helperText,
            contentPadding: widget.contentpadding,
            // enabledBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(color: Colors.black54),),
          ),
          readOnly: true,
          style: AppStyles.customFontCalibri(context),
//          firstDate: DateTime.now().subtract(Duration(days: 1)),
          initialDate: DateTime.now(),
          lastDate: widget.lastDate,
          initialValue: widget.defaultValue,
          validators: widget.validators,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
        );

      case FieldTypes.DATEPICKER:
        return FormBuilderDateTimePicker(
          autofocus: widget.autoFocus,
          attribute: widget.attribute,
          controller: widget.controller,
          enabled: widget.enable,
          inputType: InputType.date,
          firstDate: DateTime.now(),
          lastDate: DateTime(2090),
          format: DateFormat('yyyy-MM-dd'),
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: widget.labelStyle,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            counterText: widget.counterText,
            helperText: widget.helperText,
            contentPadding: widget.contentpadding,
            // enabledBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(color: Colors.black54),),
          ),
          readOnly: true,
          style: AppStyles.customFontCalibri(context),
//          firstDate: DateTime.now().subtract(Duration(days: 1)),
          initialDate: DateTime.now(),
          // lastDate: widget.lastDate,
          initialValue: widget.defaultValue,
          validators: widget.validators,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
        );

//       case FieldTypes.TIMEPICKER:
//         return FormBuilderDateTimePicker(
//           autofocus: widget.autoFocus,
//           attribute: widget.attribute,
//           controller: widget.controller,
//           enabled: widget.enable,
//           inputType: InputType.time,
//           firstDate: DateTime.now(),
//           lastDate: DateTime(2090),
//           format: DateFormat.jm(),
//           initialTime: widget.initialTime,
//           decoration: InputDecoration(
//             labelText: widget.label,
//             labelStyle: widget.labelStyle,
//             hintText: widget.hintText,
//             hintStyle: widget.hintStyle,
//             counterText: widget.counterText,
//             helperText: widget.helperText,
//             contentPadding: widget.contentpadding,
//             // enabledBorder: UnderlineInputBorder(
//             //   borderSide: BorderSide(color: Colors.black54),),
//           ),
//           readOnly: true,
//           style: AppStyles.customFontCalibri(context),
// //          firstDate: DateTime.now().subtract(Duration(days: 1)),
//           initialDate: DateTime.now(),
//           initialValue: widget.defaultValue,
//           validators: widget.validators,
//           onChanged: (value) {
//             if (widget.onChanged != null) widget.onChanged!(value);
//             if (widget.onFieldDisable != null)
//               widget.onFieldDisable!(value, widget.index);
//             if (widget.onFieldHide != null)
//               widget.onFieldHide!(value, widget.index);
//           },
//         );

      case FieldTypes.TEXTAREA:
        return FormBuilderTextField(
          controller: widget.controller,
          autofocus: widget.autoFocus,
          textAlign: widget.textAlign,
          attribute: widget.attribute,
          readOnly: !widget.enable!,
          initialValue: widget.defaultValue,
          keyboardType: TextInputType.multiline,
          maxLines: widget.maxLines,
          style: AppStyles.customFontCalibri(context),
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: widget.labelStyle,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            counterText: widget.counterText,
            helperText: widget.helperText,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.ondullColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.ondullColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.ondullColor),
            ),
          ),
          validators: widget.validators,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
        );

      case FieldTypes.SWITCH:
        return FormBuilderSwitch(
          decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              border: InputBorder.none,
              counterText: widget.counterText,
              helperText: widget.helperText),
          label: Text(
            widget.label!,
            textAlign: widget.textAlign,
            style: widget.labelStyle ??
                AppStyles.customFontCalibri(context,
                    fontSize: 14, color: ColorConstant.darkColor),
          ),
          attribute: widget.attribute,
          readOnly: !widget.enable!,
          initialValue: widget.defaultValue,
          validators: widget.validators,
          activeColor: ColorConstant.primaryColor,
          valueTransformer: (val) {
            return (val) ? '1' : '0';
          },
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
        );

      case FieldTypes.RADIO:
        return FormBuilderRadio(
            initialValue: widget.defaultValue,
            leadingInput: true,
            attribute: widget.attribute,
            readOnly: !widget.enable!,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              counterText: widget.counterText,
              helperText: widget.helperText,
              labelText: widget.label,
              labelStyle:
                  widget.labelStyle ?? AppStyles.customFontCalibri(context),
            ),
            onChanged: (value) {
              if (widget.onChanged != null) widget.onChanged!(value);
              if (widget.onFieldDisable != null)
                widget.onFieldDisable!(value, widget.index);
              if (widget.onFieldHide != null)
                widget.onFieldHide!(value, widget.index);
            },
            validators: widget.validators,
            options: widget.values!
                .map((option) => FormBuilderFieldOption(
                    value: option.value, label: option.name))
                .toList());

      case FieldTypes.INPUT:
        return FormBuilderTextField(
          controller: widget.controller,
          attribute: widget.attribute,
          // autofocus: widget.autofocus,
          initialValue: widget.defaultValue,
          textAlign: widget.textAlign,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: widget.labelStyle,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            counterText: widget.counterText,
            helperText: widget.helperText,
            contentPadding: widget.contentpadding,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.surefixIcon,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.dullColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: ColorConstant.dullColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.dullColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.dullColor),
            ),
          ),
          validators: widget.validators,
          readOnly: !widget.enable!,
          style: widget.style,
          inputFormatters: widget.inputFormatter,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
          onSaved: (value) {
            if (widget.onSaved != null) widget.onSaved!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
        );

      case FieldTypes.INPUTWITHICON:
        return FormBuilderTextField(
          controller: widget.controller,
          attribute: widget.attribute,
          focusNode: widget.focusNode,
          // autofocus: widget.autofocus,
          initialValue: widget.defaultValue,
          inputFormatters: widget.inputFormatter,
          textAlign: widget.textAlign,
          decoration: widget.decorations,
          validators: widget.validators,
          readOnly: !widget.enable!,
          style: widget.style,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
          onSaved: (value) {
            if (widget.onSaved != null) widget.onSaved!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
        );

      case FieldTypes.MOBILE:
        return FormBuilderTextField(
          controller: widget.controller,
          attribute: widget.attribute,
          initialValue: widget.defaultValue,
          readOnly: !widget.enable!,
          style: AppStyles.customFontCalibri(context),
          callCode: widget.prefix,
          textAlign: widget.textAlign,
          // maxLength: 12,
          // maxLengthEnforced: true,
          decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: widget.labelStyle,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              counterText: widget.counterText,
              helperText: widget.helperText,
              contentPadding: widget.contentpadding,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorConstant.dullColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: ColorConstant.whiteColor),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorConstant.dullColor),
              ),
              prefix: Text(widget.prefix != null ? widget.prefix! + " " : '')),
          validators: widget.validators,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(15),
          ],
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            if (widget.prefix != null) {
              value = (widget.prefix! + value);
            }
            if (widget.onChanged != null) widget.onChanged!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
        );

      case FieldTypes.EMAIL:
        return FormBuilderTextField(
          autovalidate: widget.autovalidate,
          controller: widget.controller,
          attribute: widget.attribute,
          readOnly: !widget.enable!,
          style: AppStyles.customFontCalibri(context),
          initialValue: widget.defaultValue,
          textAlign: widget.textAlign,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
            helperText: widget.helperText,
            counterText: widget.counterText,
            labelText: widget.label,
            labelStyle: widget.labelStyle,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: ColorConstant.whiteColor),
            ),
            contentPadding: widget.contentpadding,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.dullColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.dullColor),
            ),
          ),
          validators: widget.validators,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
        );

      case FieldTypes.WEBSITE:
        return FormBuilderTextField(
          controller: widget.controller,
          attribute: widget.attribute,
          textAlign: widget.textAlign,
          readOnly: !widget.enable!,
          style: AppStyles.customFontCalibri(context),
          initialValue: widget.defaultValue,
          decoration: InputDecoration(
              helperText: widget.helperText,
              counterText: widget.counterText,
              labelText: widget.label,
              labelStyle: widget.labelStyle,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle),
          validators: widget.validators,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.url,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
        );

      case FieldTypes.NUMBER:
        return FormBuilderTextField(
          controller: widget.controller,
          attribute: widget.attribute,
          readOnly: !widget.enable!,
          textAlign: widget.textAlign,
          style: AppStyles.customFontCalibri(context),
          initialValue: widget.defaultValue,
          decoration: InputDecoration(
            helperText: widget.helperText,
            counterText: widget.counterText,
            labelText: widget.label,
            labelStyle: widget.labelStyle,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            // enabledBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(color: Colors.black54),
            // ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: ColorConstant.whiteColor),
            ),
            contentPadding: widget.contentpadding,

            // border: UnderlineInputBorder(
            //   borderSide: BorderSide(color: Colors.black54),
            // ),
          ),
          validators: widget.validators,
          keyboardType: TextInputType.number,
          maxLength: widget.maxLength,
          maxLengthEnforced: widget.maxLengthEnforced,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
        );

      case FieldTypes.HOURMIN:
        var _initialValue = "";
        _initialValue =
            (widget.defaultValue != '' && widget.defaultValue != null)
                ? widget.defaultValue
                : _initialValue;
        return FormBuilderTextField(
          controller: widget.controller,
          attribute: widget.attribute,
          textAlign: widget.textAlign,
          readOnly: !widget.enable!,
          style: AppStyles.customFontCalibri(context),
          initialValue: _initialValue,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: "HH:MM",
            labelStyle: widget.labelStyle,
            hintStyle: widget.hintStyle,
            helperText: widget.helperText,
            counterText: widget.counterText,
            contentPadding: widget.contentpadding,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9:]")),
          ],
          validators: widget.validators,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
          valueTransformer: (value) {
            String val = _hourMin(value);
            return val;
          },
          keyboardType: TextInputType.datetime,
        );

      case FieldTypes.CHECKBOX:
        return FormBuilderCheckboxList(
            checkColor: ColorConstant.whiteColor, // color of tick Mark
            activeColor: ColorConstant.primaryColor,
            decoration: InputDecoration(
                labelText: widget.label,
                labelStyle: widget.labelStyle,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle,
                helperText: widget.helperText,
                counterText: widget.counterText,
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: widget.contentpadding,
                border: InputBorder.none),
            attribute: widget.attribute,
            leadingInput: true,
            readOnly: !widget.enable!,
            initialValue: widget.defaultValue,
            validators: widget.validators,
            onChanged: (value) {
              if (widget.onChanged != null) widget.onChanged!(value);
              if (widget.onFieldDisable != null)
                widget.onFieldDisable!(value, widget.index);
              if (widget.onFieldHide != null)
                widget.onFieldHide!(value, widget.index);
            },
            options: widget.values!
                .map((option) => FormBuilderFieldOption(
                    value: option.id,
                    label: option.name,
                    labelStyle: widget.labelStyle))
                .toList());

      case FieldTypes.LABLE:
        return Container(
          child: Row(
            children: <Widget>[
              Text(
                widget.label!,
                textAlign: widget.textAlign,
                style: widget.labelStyle,
              ),
            ],
          ),
        );

      case FieldTypes.FILE:
        return FormBuilderFilePicker(
          controller: widget.controller,
          attribute: widget.attribute,
          textAlign: widget.textAlign,
          initialValue: widget.defaultValue,
          style: AppStyles.customFontCalibri(context, fontSize: 14),
          decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              helperText: widget.helperText,
              counterText: widget.counterText,
              labelStyle: widget.labelStyle ??
                  AppStyles.customFontCalibri(context,
                      fontSize: 14, color: ColorConstant.darkColor54),
              border: Theme.of(context).inputDecorationTheme.border),
          validators: widget.validators,
          showCursor: false,
          onChanged: (filename, path) {
            try {
              if (widget.onFilePicked != null)
                widget.onFilePicked!(filename, path);
              if (widget.onFieldDisable != null)
                widget.onFieldDisable!(filename, widget.index);
              if (widget.onFieldHide != null)
                widget.onFieldHide!(filename, widget.index);
            } catch (e) {
              print(e);
            }
          },
        );

      case FieldTypes.PASSWORD:
        return FormBuilderPasswordField(
          controller: widget.controller,
          textAlign: widget.textAlign,
          attribute: widget.attribute,
          initialValue: widget.defaultValue,
          style: widget.style,
          decoration: InputDecoration(
            // prefixIconConstraints: BoxConstraints(maxWidth: 30, minWidth: 1),
            labelText: widget.label,
            labelStyle: widget.labelStyle,
            helperText: widget.helperText,
            counterText: widget.counterText,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            counter: Gaps.empty,
            contentPadding: widget.contentpadding,
            prefixIcon: widget.prefixIcon,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.whiteColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: ColorConstant.whiteColor),
            ),
            // UnderlineInputBorder(
            //   borderSide: BorderSide(color: ColorConstant.whiteColor),
            // ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.whiteColor),
            ),
          ),
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          maxLengthEnforced: widget.maxLengthEnforced,
          validators: widget.validators,
          readOnly: !widget.enable!,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!(value, widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!(value, widget.index);
          },
        );

      // case FieldTypes.HOSTPASSWORD:
      //   return FormBuilderHostPasswordField(
      //     controller: widget.controller,
      //     textAlign: widget.textAlign,
      //     attribute: widget.attribute,
      //     initialValue: widget.defaultValue,
      //     style: AppStyles.customFontCalibri(context),
      //     decoration: InputDecoration(
      //       labelText: widget.label,
      //       labelStyle: widget.labelStyle,
      //       helperText: widget.helperText,
      //       counterText: widget.counterText,
      //       hintText: widget.hintText,
      //       hintStyle: widget.hintStyle,
      //       counter: Gaps.empty,
      //       contentPadding:
      //       EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
      //
      //       // enabledBorder: UnderlineInputBorder(
      //       //   borderSide: BorderSide(color: Colors.black54),
      //       // ),
      //       focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      //
      //       // border: UnderlineInputBorder(
      //       //   borderSide: BorderSide(color: Colors.black54),
      //       // ),
      //     ),
      //     keyboardType: widget.keyboardType,
      //     maxLength: widget.maxLength,
      //     maxLengthEnforced: widget.maxLengthEnforced,
      //     validators: widget.validators,
      //     readOnly: !widget.enable!,
      //     onChanged: (value) {
      //       if (widget.onChanged != null) widget.onChanged!(value);
      //       if (widget.onFieldDisable != null)
      //         widget.onFieldDisable!(value, widget.index);
      //       if (widget.onFieldHide != null)
      //         widget.onFieldHide!(value, widget.index);
      //     },
      //   );

      case FieldTypes.TEXTICONBUTTON:
        return TextButton.icon(
          icon: widget.TextIcon!,
          style: TextButton.styleFrom(
            textStyle: TextStyle(color: Colors.blue),
            backgroundColor: ColorConstant.appbarColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.height * 0.005)),
            ),
          ),
          label: Text(
            widget.label ?? 'Submit',
            textAlign: widget.textAlign,
            style: widget.labelStyle ??
                AppStyles.customFontCalibri(
                  context,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Theme.of(context).buttonTheme.colorScheme!.secondary,
                ),
          ),
          onPressed: () {
            if (widget.onChanged != null) widget.onChanged!('');
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!("", widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!("", widget.index);
          },
        );

      case FieldTypes.BUTTON:
        return MaterialButton(
          // color: Theme.of(context).buttonTheme.colorScheme!.primary,
          color: ColorConstant.primaryColor,
          minWidth: MediaQuery.of(context).size.width * 0.90,
          height: 40,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(3.0)),
          child: Text(
            widget.label ?? 'Submit',
            textAlign: widget.textAlign,
            style: widget.labelStyle ??
                AppStyles.customFontCalibri(
                  context,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Theme.of(context).buttonTheme.colorScheme!.secondary,
                ),
          ),
          onPressed: () {
            if (widget.onChanged != null) widget.onChanged!('');
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!("", widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!("", widget.index);
          },
        );

      case FieldTypes.OUTLINEBUTTON:
        return MaterialButton(
          minWidth: MediaQuery.of(context).size.width * 0.85,
          height: 56,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
              side: BorderSide(
                  color: Theme.of(context).buttonTheme.colorScheme!.primary)),
          child: Text(
            widget.label ?? 'Submit',
            textAlign: widget.textAlign,
            style: widget.labelStyle ??
                AppStyles.customFontCalibri(
                  context,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).buttonTheme.colorScheme!.primary,
                ),
          ),
          onPressed: () {
            if (widget.onChanged != null) widget.onChanged!('');
            if (widget.onFieldDisable != null)
              widget.onFieldDisable!("", widget.index);
            if (widget.onFieldHide != null)
              widget.onFieldHide!("", widget.index);
          },
        );
      default:
        break;
    }
  }

  _hourMin(digits) {
    String val = digits;
    val = val.replaceAll(new RegExp('0-9:'), '');
    if (val.indexOf(':') > -1) {
      var durationArray = val.split(':');

      if (durationArray[0].length == 0) {
        durationArray[0] = '00';
      }

      if (durationArray[1] != '') {
        if (int.parse(durationArray[1]) >= 60) {
          var subtr = (int.parse(durationArray[1]) / 60).floor();
          durationArray[0] = (subtr + int.parse(durationArray[0])).toString();
          durationArray[1] =
              (int.parse(durationArray[1]) - (subtr * 60)).toString();
        }
      }

      if (durationArray[0].toString().length == 1) {
        durationArray[0] = '0' + durationArray[0];
      }

      if (durationArray[1].toString().length == 1) {
        durationArray[1] = '0' + durationArray[1];
      } else if (durationArray[1].toString().length == 0) {
        durationArray[1] = '00';
      }

      val = durationArray[0] + ':' + durationArray[1];
    } else if (val.length == 1 && val.indexOf(':') == -1) {
      val = '0' + val + ':' + '00';
    } else if (val.length >= 2 && val.indexOf(':') == -1) {
      val = val + ':' + '00';
    }
    val = val == '00:00' ? '' : val;
    return val;
  }

  _dropDownValue() {
    if (_values!.isNotEmpty) {
      _values!.clear();
    }
//    _values = [
//      FilterEntityObject(id: '', name: 'Select', value: '')
//    ];
    widget.values!.map((selected) {
      if (widget.values!.first.id == selected.id)
        _values!.add(FilterEntityObject(id: '', name: 'Select', value: ''));
      _values!.add(FilterEntityObject(id: selected.id, name: selected.name));
    }).toList();
    //
  }
}

class DropDownProvider extends ChangeNotifier {
  List _values = [];

  List get values => _values;

  void setDropDownValue(List data) {
    if (_values.isEmpty) {
      _values.clear();
    }
    data.map((selected) {
      if (data.first.id == selected.id)
        _values.add(FilterEntityObject(id: '', name: 'Select', value: ''));
      _values.add(FilterEntityObject(id: selected.id, name: selected.name));
    }).toList();
  }
}
