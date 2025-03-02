import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00BCD4); // Turquesa Brillante
  static const Color secondaryColor = Color(0xFF6A0572); // Púrpura vibrante
  static const Color accentColor = Color(0xFFFFA500); // Naranja vibrante
  static const Color backgroundColor = Color(0xFFFFF8E1); // Crema pastel
  static const Color cardColor = Color(0xFFFFFFFF); // Blanco puro
  static const Color textColor = Color(0xFF333333); // Texto oscuro
  static const Color iconColor = Color(0xFF555555); // Íconos con buen contraste
  static const Color inputBackgroundColor = Color(0xFFECEFF1); // Gris claro

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: cardColor,
      // onSurface: backgroundColor,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      bodySmall: TextStyle(fontSize: 16, color: Colors.black54),
    ),
    cardTheme: CardTheme(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      shadowColor: Colors.black26,
    ),
    iconTheme: const IconThemeData(color: iconColor),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: textColor),
      hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
