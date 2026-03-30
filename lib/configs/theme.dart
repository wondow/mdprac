import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFFFFF8F6);
  static const Color primary = Color(0xFF735266);
  static const Color primaryContainer = Color(0xFF8D6A7F);
  static const Color secondary = Color(0xFF6A5B56);
  static const Color surfaceContainer = Color(0xFFFEEAE3);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color textMain = Color(0xFF231915);
  static const Color textVariant = Color(0xFF4E4449);

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.notoSerif(color: textMain, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic),
        displayMedium: GoogleFonts.notoSerif(color: textMain, fontWeight: FontWeight.w400),
        bodyLarge: GoogleFonts.manrope(color: textMain, fontWeight: FontWeight.w500),
        bodyMedium: GoogleFonts.manrope(color: textVariant, fontWeight: FontWeight.w400),
        labelSmall: GoogleFonts.manrope(color: textVariant, fontWeight: FontWeight.w700, letterSpacing: 1.5),
      ),
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: background,
      ),
    );
  }
}