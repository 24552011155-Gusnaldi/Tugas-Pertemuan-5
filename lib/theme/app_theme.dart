import 'package:flutter/material.dart';

class AppTheme {
  static const Color ink = Color(0xFF202923);
  static const Color green = Color(0xFF397A59);
  static const Color canvas = Color(0xFFF7F8F5);
  static const Color muted = Color(0xFF858D86);

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: green,
      primary: green,
      surface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: canvas,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: canvas,
        foregroundColor: ink,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: canvas,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: green, width: 1.5),
        ),
      ),
    );
  }
}
