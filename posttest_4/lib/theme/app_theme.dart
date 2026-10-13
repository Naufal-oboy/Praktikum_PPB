import 'package:flutter/material.dart';

/// Kumpulan warna & style yang dipakai berulang di seluruh aplikasi.
class AppColors {
  static const Color primary = Color(0xFF4B5563);
  static const Color primaryDark = Color(0xFF374151);
  static const Color primaryLight = Color(0xFFF3F4F6);
  static const Color border = Color(0xFFE5E7EB);
  static const Color muted = Color(0xFF6B7280);
}

/// ThemeData utama aplikasi, dipakai di MaterialApp.
final ThemeData appTheme = ThemeData(
  fontFamily: 'Inter',
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
);
