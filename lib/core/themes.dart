import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:henry_flutter_news/core/colors.dart';

class Themes {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: Colors.blue,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
          color: Colours.kTextColorOnLight,
          fontSize: 24,
          fontWeight: FontWeight.bold),
      displayMedium: GoogleFonts.lato(
        color: Colours.kTextColorOnLight,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.lato(
        color: Colours.kTextColorOnLight,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: GoogleFonts.lato(
        color: Colours.kTextColorOnLight,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
