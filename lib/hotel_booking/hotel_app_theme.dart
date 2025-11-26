import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';

class HotelAppTheme {
  static TextTheme _buildTextTheme(TextTheme base) {
    const String fontName = 'WorkSans';
    return base.copyWith(
   displayLarge: base.displayLarge?.copyWith(fontFamily: fontName),
displayMedium: base.displayMedium?.copyWith(fontFamily: fontName),
displaySmall: base.displaySmall?.copyWith(fontFamily: fontName),
headlineMedium: base.headlineMedium?.copyWith(fontFamily: fontName),
headlineSmall: base.headlineSmall?.copyWith(fontFamily: fontName),
titleLarge: base.titleLarge?.copyWith(fontFamily: fontName),
titleMedium: base.titleMedium?.copyWith(fontFamily: fontName),
titleSmall: base.titleSmall?.copyWith(fontFamily: fontName),
bodyLarge: base.bodyLarge?.copyWith(fontFamily: fontName),
bodyMedium: base.bodyMedium?.copyWith(fontFamily: fontName),
bodySmall: base.bodySmall?.copyWith(fontFamily: fontName),
labelLarge: base.labelLarge?.copyWith(fontFamily: fontName),
labelSmall: base.labelSmall?.copyWith(fontFamily: fontName),

    );
  }

  static ThemeData buildLightTheme() {
    final Color primaryColor = HexColor('#54D3C2');
    final Color secondaryColor = HexColor('#54D3C2');
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();
    return ThemeData(
  colorScheme: colorScheme.copyWith(
    error: const Color(0xFFB00020),
  ),
  primaryColor: colorScheme.primary,
  scaffoldBackgroundColor: const Color(0xFFF6F6F6),
  canvasColor: Colors.white,
  
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: colorScheme.primary,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: Colors.white,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: colorScheme.primary,
    ),
  ),
);

  }
}
