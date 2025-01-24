import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Paleta de colores refinada (azules oscuros y claros)
  static const Color primaryColor = Color(0xFF1A237E);     // Azul marino profundo
  static const Color secondaryColor = Color(0xFF3F51B5);   // Azul medio
  static const Color backgroundColor = Color(0xFFF5F5F5);   // Gris neutro claro
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF424242);      // Gris neutro oscuro
  static const Color accentColor = Color(0xFF9FA8DA);    // Azul claro pastel

  static const Color darkPrimaryColor = Color(0xFF121940);     // Azul marino más profundo
  static const Color darkSecondaryColor = Color(0xFF283593);   // Azul medio oscuro
  static const Color darkBackgroundColor = Color(0xFF121212);   // Gris oscuro
  static const Color darkCardColor = Color(0xFF1E1E1E);
  static const Color darkTextColor = Color(0xFFE0E0E0);

  // Nuevos colores para los iconos
  static const Color iconLightColor = Color(0xFF1A237E); // Azul oscuro para iconos en tema claro
  static const Color iconDarkColor = Color(0xFF9FA8DA);  // Azul claro para iconos en tema oscuro

  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        cardColor: cardColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.light().textTheme.copyWith(
            headlineLarge: TextStyle(
              color: textColor,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
            headlineMedium: TextStyle(
              color: textColor,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: TextStyle(
              color: textColor,
              fontSize: 15,
            ),
            titleLarge: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),
            titleMedium: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500
            ),
            bodyMedium: TextStyle(
                color: textColor.withOpacity(0.8),
                fontSize: 14
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
            shadowColor: Colors.black26,

          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: iconLightColor),  // Iconos azules oscuros en tema claro
        ),
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          surface: cardColor,
          background: backgroundColor,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: textColor,
          onBackground: textColor,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primaryColor.withOpacity(0.3))
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primaryColor)
            ),
            prefixIconColor: primaryColor,
            labelStyle: TextStyle(color: textColor)
        )
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
        primaryColor: darkPrimaryColor,
        scaffoldBackgroundColor: darkBackgroundColor,
        cardColor: darkCardColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme.copyWith(
            headlineLarge: TextStyle(
              color: darkTextColor,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
            headlineMedium: TextStyle(
              color: darkTextColor,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: TextStyle(
              color: darkTextColor,
              fontSize: 15,
            ),
            titleLarge: TextStyle(
                color: darkTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),
            titleMedium: TextStyle(
                color: darkTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500
            ),
            bodyMedium: TextStyle(
                color: darkTextColor.withOpacity(0.8),
                fontSize: 14
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkPrimaryColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
            shadowColor: Colors.black26,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: iconDarkColor),  // Iconos azules claros en tema oscuro
        ),
        colorScheme: ColorScheme.dark(
          primary: darkPrimaryColor,
          secondary: darkSecondaryColor,
          surface: darkCardColor,
          background: darkBackgroundColor,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: darkTextColor,
          onBackground: darkTextColor,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: darkPrimaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: darkPrimaryColor.withOpacity(0.3))
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: darkPrimaryColor)
            ),
            prefixIconColor: darkPrimaryColor,
            labelStyle: TextStyle(color: darkTextColor)
        )
    );
  }
}