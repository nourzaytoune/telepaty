import 'package:flutter/material.dart';

class AppTheme {
  static final primarySwatchColor = Color.fromARGB(255, 35, 54, 70);
  static final primaryColor = MaterialColor(
    primarySwatchColor.value,
    <int, Color>{
      50: primarySwatchColor.withOpacity(0.1),
      100: primarySwatchColor.withOpacity(0.2),
      200: primarySwatchColor.withOpacity(0.3),
      300: primarySwatchColor.withOpacity(0.4),
      400: primarySwatchColor.withOpacity(0.5),
      500: primarySwatchColor.withOpacity(0.6),
      600: primarySwatchColor.withOpacity(0.7),
      700: primarySwatchColor.withOpacity(0.8),
      800: primarySwatchColor.withOpacity(0.9),
      900: primarySwatchColor,
    },
  );

  static ThemeData get theme {
    return ThemeData(
      primarySwatch: primaryColor,
      // Add any other custom theme settings here
    );
  }
}
