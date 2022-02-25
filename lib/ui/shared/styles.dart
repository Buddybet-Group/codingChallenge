//Colors
import 'package:flutter/material.dart';
//colors
const Color appColor009FDF = Color(0xFF009FDF);
const Color appColore5e6eb = Color(0xFFe5e6eb);

//Padding
const EdgeInsets padding20 = EdgeInsets.all(20.0);
const EdgeInsets padding10 = EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0, bottom: 0.0);
const EdgeInsets margin10 = EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0);


//Textstyle
const TextStyle fontFamilyPoppinsRegular = TextStyle(fontFamily: 'Poppins-Regular');


//sizedbox
const verticalSpacing20 = SizedBox(height: 20.0);
const verticalSpacing10 = SizedBox(height: 10.0);
const verticalSpacing60 = SizedBox(height: 60.0);

//sized box
extension TextStyleHelpers on TextStyle {
  TextStyle get size16 => copyWith(fontSize: 16);

  TextStyle get size18 => copyWith(fontSize: 18);

  TextStyle get color13D869 => copyWith(color: appColor009FDF);

  TextStyle get black => copyWith(color: Colors.black);

  TextStyle get white => copyWith(color: Colors.white);

}

const Divider horizontalDivider = Divider(height: 2, color: appColor009FDF);

RadialGradient boxGradient = const RadialGradient(
  center: Alignment(0.95, 0.8),
  radius: 0.75,
  colors: <Color>[
    appColor009FDF,
    appColor009FDF,
  ],
  stops: <double>[0.4, 1.0],
);