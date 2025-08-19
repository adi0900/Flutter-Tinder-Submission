import 'package:flutter/material.dart';

class AppColors {
  static const Color peach = Color(0xFFFFF3E0);
  static const Color lightPeach = Color(0xFFFFF8F0);
  static const Color softPeach = Color(0xFFFFE4C4);
  static const Color maroon = Color(0xFFD7837F);
  static const Color darkMaroon = Color(0xFFB86B65);
  static const Color accent = Color(0xFFE8A598);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFFFFBFF);
  static const Color lightGray = Color(0xFFF8F8F8);
  static const Color softGray = Color(0xFFEFEFEF);
  static const Color darkGray = Color(0xFF757575);
  static const Color textGray = Color(0xFF9E9E9E);
  
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFF8F0),
      Color(0xFFFFE4C4),
      Color(0xFFE8A598),
    ],
    stops: [0.0, 0.6, 1.0],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [offWhite, lightPeach],
  );

  static const LinearGradient softButtonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, maroon],
  );
  
  static const LinearGradient tabGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [softPeach, accent],
  );
  
  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [maroon, darkMaroon],
  );
}