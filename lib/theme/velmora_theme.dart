import 'package:flutter/material.dart';

class VelmoraTheme {
  static const bg = Color(0xFFFAF5FF);
  static const surface = Color(0xFFFFFFFF);
  static const edge = Color(0xFFE9D5FF);
  static const accent = Color(0xFF9333EA);
  static const accentLight = Color(0xFFC084FC);
  static const ink = Color(0xFF3B0764);
  static const muted = Color(0xFF6B21A8);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: bg,
      fontFamily: 'AppFont',
      primaryColor: accent,
      colorScheme: const ColorScheme.light(
        primary: accent,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        foregroundColor: ink,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: surface,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: edge, width: 1.5),
        ),
      ),
    );
  }
}
