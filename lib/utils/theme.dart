import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final BuildContext _context;
  final VisualDensity _density = VisualDensity.adaptivePlatformDensity;
  // final _dividerThemeData = DividerThemeData(endIndent: 10, indent: 10);

  AppTheme(this._context);

  final _black = Colors.grey[900];
  final _white = Colors.white;

  ThemeData get light {
    TextTheme textTheme = Theme.of(_context).textTheme.apply(
          bodyColor: _black,
          displayColor: _black,
          decorationColor: _black,
        );
    return ThemeData.light().copyWith(
      visualDensity: _density,
      primaryColor: _white,
      backgroundColor: _black,
      accentColor: Color(0xff163d6d),

      textTheme: GoogleFonts.openSansTextTheme(textTheme),
      // dividerTheme: _dividerThemeData,
      appBarTheme: AppBarTheme(
        color: Colors.grey.shade50,
        // elevation: 0,

        iconTheme: IconThemeData(color: _black),
        textTheme: textTheme,
      ),
      scaffoldBackgroundColor: _white,
      iconTheme: IconThemeData(color: _black),
      inputDecorationTheme: InputDecorationTheme(
        alignLabelWithHint: false,
        // filled: true,
        errorMaxLines: 1,
        // fillColor: _white,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
            vertical: GetPlatform.isWeb ? 14 : 10, horizontal: 10),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff163d6d))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff163d6d), width: 2)),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        isCollapsed: false,
        labelStyle: TextStyle(color: Colors.grey[700]),
      ),
      elevatedButtonTheme: GetPlatform.isWeb
          ? ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              ),
            )
          : null,
    );
  }
}
