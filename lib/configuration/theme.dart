import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
  static const Color inputBorderGreen = Color(0xFFAED9B9); // Bordure verte claire
  static const Color inputFocusGreen = Color(0xFF43A047); // Focus vert doux
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
    String? labelText,
    IconData? suffixIcon,
    Widget? suffix,
    bool isPassword = false,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: textSecondary,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      hintText: hintText,
      hintStyle: hintStyle,
      suffixIcon: suffix ??
          (suffixIcon != null
              ? Icon(suffixIcon, color: greyLight, size: 20)
              : null),
      filled: true,
      fillColor: inputFillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: inputBorderGreen, width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: inputBorderGreen, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: inputFocusGreen, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor, width: 1.8),
      ),
    );
  }

  // Button styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryGreen,
    elevation: 2,
    shadowColor: Colors.black.withValues(alpha: 0.1),
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
        surface: backgroundColor,
        error: errorColor,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
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
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: const TextStyle(
          color: textSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: inputBorderGreen, width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: inputBorderGreen, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: inputFocusGreen, width: 1.8),
        ),
        hintStyle: hintStyle,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: SoftPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: SoftPageTransitionsBuilder(),
          TargetPlatform.linux: SoftPageTransitionsBuilder(),
          TargetPlatform.macOS: SoftPageTransitionsBuilder(),
        },
      ),
      textTheme: const TextTheme(
        displayLarge: titleStyle,
        titleLarge: titleStyle,
        titleMedium: subtitleStyle,
        bodyMedium: labelStyle,
      ),
      iconTheme: const IconThemeData(color: textPrimary),
      dividerTheme: const DividerThemeData(color: borderColor, thickness: 1),
    );
  }
}

// Transition de page sobre et épurée (inspirée d'iOS)
class SoftPageTransitionsBuilder extends PageTransitionsBuilder {
  const SoftPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.04),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}
