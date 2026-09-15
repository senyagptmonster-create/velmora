import 'package:flutter/material.dart';

class VelmoraTheme {
  static const Color calmingSage = Color(0xFF5B8266);
  static const Color softLavender = Color(0xFF8E9AAF);
  static const Color warmCream = Color(0xFFFBFBF2);
  static const Color darkSlate = Color(0xFF264653);
  static const Color cardOutline = Color(0xFFE5E7EB);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'AppFont',
      scaffoldBackgroundColor: warmCream,
      colorScheme: const ColorScheme.light(
        primary: calmingSage,
        secondary: softLavender,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSurface: darkSlate,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: calmingSage,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
