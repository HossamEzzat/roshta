import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFFD700), // Gold
      onPrimary: Colors.black,
      secondary: Color(0xFFD4AF37), // Metallic Gold
      onSecondary: Colors.black,
      surface: Color(0xFF121212), // Deep Black
      onSurface: Colors.white,
      surfaceContainerHighest: Color(0xFF1E1E1E),
      onSurfaceVariant: Color(0xFFCCCCCC),
    ),
    scaffoldBackgroundColor: const Color(0xFF000000), // Pure Black for OLED
    textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
  );
}
