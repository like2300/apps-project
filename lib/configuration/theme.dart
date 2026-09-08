import 'package:flutter/material.dart';

// Déclaration des polices personnalisées
// (À utiliser une fois les polices ajoutées)
const String fontPoppinsRegular = 'Poppins';
const String fontPoppinsMedium = 'Poppins';
const String fontPoppinsSemiBold = 'Poppins';
const String fontPoppinsBold = 'Poppins';

class AppTheme {
  // Couleurs officielles pour MY CAMU (Vert officiel de la CAMU)
  static const Color primaryGreen = Color(0xFF0A8B42); // Vert CAMU
  static const Color backgroundColor = Color(0xFFF7F9FC); // Fond clair
  static const Color textPrimary = Color(0xFF212121); // Texte principal
  static const Color textSecondary = Color(0xFF757575); // Sous-titres
  static const Color textHint = Color(0xFFBDBDBD); // Textes d'indication
  static const Color textButton = Colors.white;
  static const Color inputFillColor = Color(0xFFF5F5F5); // Fond des champs
  static const Color borderColor = Color(0xFFE0E0E0); // Bordures
  static const Color errorColor = Color(0xFFD32F2F); // Erreurs
  static const Color successColor = Color(0xFF388E3C); // Succès
  static const Color greyLight = Color(0xFF9E9E9E); // Icônes secondaires

  // Text styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    letterSpacing: 0.3,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textSecondary,
  );

  static const TextStyle labelStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: textPrimary,
  );

  static const TextStyle hintStyle = TextStyle(
    color: textHint,
    fontSize: 14,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    color: textButton,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle errorTextStyle = TextStyle(
    color: errorColor,
    fontSize: 14,
  );

  static const TextStyle successTextStyle = TextStyle(
    color: successColor,
    fontSize: 14,
  );

  // Input decoration
  static InputDecoration inputDecoration({
    required String hintText,
    IconData? suffixIcon,
    bool isPassword = false,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle,
      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: greyLight, size: 20)
          : null,
      filled: true,
      fillColor: inputFillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
    );
  }

  // Button styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryGreen,
    elevation: 2,
    shadowColor: Colors.black.withOpacity(0.1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 16),
  );

  static ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: primaryGreen,
    side: const BorderSide(color: primaryGreen, width: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 16),
    minimumSize: const Size(double.infinity, 54),
  );

  // ThemeData
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primaryGreen,
        secondary: primaryGreen,
        background: backgroundColor,
        error: errorColor,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryGreen,
          padding: EdgeInsets.zero,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: primaryButtonStyle,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: outlinedButtonStyle,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFillColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        hintStyle: hintStyle,
      ),
      textTheme: TextTheme(
        displayLarge: titleStyle,
        titleLarge: titleStyle,
        titleMedium: subtitleStyle,
        bodyMedium: labelStyle,
      ),
      iconTheme: IconThemeData(color: textPrimary),
      dividerTheme: DividerThemeData(color: borderColor, thickness: 1),
    );
  }
}
