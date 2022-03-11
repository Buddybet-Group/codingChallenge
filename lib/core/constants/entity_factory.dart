import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/shared_preferences_utils_impl.dart';

enum StateType {
  loading,
  empty,
  error,
  Success,
}
enum AppType { Debug, Release }
enum Method { get, post }
enum ButtonType { Save, Edit, Delete }

class FilterEntityObject {
  FilterEntityObject({
    this.id,
    this.name,
    this.value,
    this.icon,
  });

  String? id;
  String? name;
  String? value;
  IconData? icon;
}

class FormBuilderFieldOption {
  String? label;
  dynamic value;
  TextStyle? labelStyle;
  FormBuilderFieldOption({this.label, required this.value, this.labelStyle});
}

enum FieldTypes {
  INPUT,
  INPUTWITHICON,
  MOBILE,
  EMAIL,
  WEBSITE,
  HOURMIN,
  NUMBER,
  DROPDOWN,
  MULTIPLEDROPDOWN,
  TEXTAREA,
  LABLE,
  AUTOCOMPLETE,
  RADIO,
  CHECKBOX,
  DATETIMEPICKER,
  DATEPICKER,
  SWITCH,
  FILE,
  PASSWORD,
  BUTTON,
  TEXTICONBUTTON,
  OUTLINEBUTTON
}

enum Lang { Tamil, English }

class LangFontSize {
  final Lang? lang;
  final double? fontSize;
  const LangFontSize({this.lang, this.fontSize});
}

class LanguageHelper {
  static String getLanguageCode(Lang? lang) {
    switch (lang!) {
      case Lang.Tamil:
        return 'ta';
      case Lang.English:
        return 'en';
    }
    return 'en';
  }

  static String getLanguageName(String? code) {
    switch (code) {
      case 'ta':
        return 'தமிழ்';

      default:
        return 'English';
    }
  }

  double? getLangFontSize(
      {required List<LangFontSize> langFontSizes, double? defaultFontSize}) {
    try {
      if (langFontSizes != null &&
          SharedPreferencesUtilsImpl.curr_language != null) {
        for (int i = 0; i < langFontSizes.length; i++) {
          if (getLanguageCode(langFontSizes[i].lang) ==
              SharedPreferencesUtilsImpl.curr_language!.languageCode) {
            return langFontSizes[i].fontSize;
          }
        }
      }
    } catch (e) {}
    return defaultFontSize ?? 14;
  }
}

abstract class Gaps {
  static Widget empty = SizedBox();
  static Widget divider = Divider();

  static Widget vGap(double height) {
    return SizedBox(height: height);
  }

  static Widget hGap(double width) {
    return SizedBox(width: width);
  }
}

abstract class AppStyles {
  static TextStyle customFontCalibri(BuildContext context,
      {double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? textDecoration,
      Color? color,
      String? fontFamily}) {
    if (color == null) {
      color = Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;
    }
    return
        //   TextStyle(
        //   color: color,
        //   fontFamily: "Calibri",
        //   fontSize: fontSize ?? 14,
        //   fontWeight: fontWeight,
        //   fontStyle: fontStyle,
        //   decoration: textDecoration,
        // );
        GoogleFonts.play(
      color: color,
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: textDecoration,
    );
  }

  static TextStyle customFontopenSansRoboto(BuildContext context,
      {double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? textDecoration,
      Color? color,
      String? fontFamily}) {
    if (color == null) {
      color = Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;
    }
    return GoogleFonts.roboto(
      color: color,
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: textDecoration,
    );
  }

  static InputDecoration InputDecorationWidget(
      {required BuildContext context, required String hintText}) {
    return InputDecoration(
      hintText: hintText.isNotEmpty ? hintText : "Enter your main domain",
      hintStyle: AppStyles.customFontCalibri(context,
          color: Colors.black12, fontSize: 12.0, fontWeight: FontWeight.normal),
      counterText: "",
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorConstant.primaryColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorConstant.primaryColor),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorConstant.primaryColor),
      ),
    );
    ;
  }

  static progress(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: ColorConstant.pageColor,
        backgroundColor: ColorConstant.appbarColor,
      ),
    );
  }

  static exitApp(MediaQueryData mediaQueryData, BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: ColorConstant.pageColor,
            title: Text('Are you sure to Exit?',
                style: AppStyles.customFontCalibri(context,
                    color: ColorConstant.whiteColor,
                    fontSize:
                        AdaptiveTextSize().getadaptiveTextSize(context, 16),
                    fontWeight: FontWeight.bold)),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(mediaQueryData.size.height * 0.02),
                  primary: ColorConstant.primaryColor,
                  backgroundColor: ColorConstant.primaryColor,
                  textStyle: TextStyle(
                      fontSize:
                          AdaptiveTextSize().getadaptiveTextSize(context, 16)),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                }, // passing false
                child: Text('No',
                    style: AppStyles.customFontCalibri(context,
                        fontSize:
                            AdaptiveTextSize().getadaptiveTextSize(context, 16),
                        color: ColorConstant.whiteColor)),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor,
                  padding: EdgeInsets.all(mediaQueryData.size.height * 0.02),
                  primary: ColorConstant.whiteColor,
                  textStyle: TextStyle(
                      fontSize:
                          AdaptiveTextSize().getadaptiveTextSize(context, 16)),
                ),
                onPressed: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                }, // passing true
                child: Text(
                  'Yes',
                  style: AppStyles.customFontCalibri(context,
                      fontSize:
                          AdaptiveTextSize().getadaptiveTextSize(context, 16),
                      color: ColorConstant.whiteColor),
                ),
              ),
            ],
          );
        }).then((exit) {
      if (exit == null) return;

      if (exit) {
        // user pressed Yes button
      } else {
        // user pressed No button
      }
    });
  }
}

Widget MyMaterialButton(BuildContext context,
    {String? label,
    TextStyle? labelStyle,
    required Function onPressed,
    double? height,
    double? width,
    Colors? color}) {
  return MaterialButton(
    color:
        color as Color? ?? Theme.of(context).buttonTheme.colorScheme!.primary,
    minWidth: width ?? 60,
    height: height ?? 30,
    shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0)),
    child: Text(
      label ?? 'Join',
      style: labelStyle ??
          AppStyles.customFontCalibri(
            context,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.white,
          ),
    ),
    onPressed: onPressed as void Function()?,
  );
}

class ColorConstant {
  static Color primaryColor = Color(0xffffffff);
  static Color onprimaryColor = Color(0xffe5e6ec);
  static Color whiteColor54 = Colors.white54;
  static Color whiteColor70 = Colors.white70;
  static Color darkColor = Color(0xff000000);
  static Color darkColor54 = Colors.black54;
  static Color ongreyColor = Colors.grey;

  static Color appbarColor = Color(0xff0fa0de);
  static Color pageColor = Color(0xffffffff);
  static Color onpageColor = Color(0xffCCA979);
  static Color secondaryColor = Color(0xff67b9e8);
  static Color whiteColor = Color(0xffffffff);
  static Color dullColor = Colors.black54;
  static Color ondullColor = Color(0xffF2F2F2);
  static Color alertdialougecardColor = Color(0xff0000001F);
}

class AdaptiveTextSize {
  const AdaptiveTextSize();
  getadaptiveTextSize(BuildContext context, dynamic value) {
    final mediaQuery = MediaQuery.of(context);
    if (mediaQuery.size.width > 1024) {
      return (value / 1024) * MediaQuery.of(context).size.height;
    }
    if (mediaQuery.size.width > 332) {
      return (value / 720) * MediaQuery.of(context).size.height;
    }
    // 720 is medium screen height
    return (value / 720) * MediaQuery.of(context).size.height;
  }
}
