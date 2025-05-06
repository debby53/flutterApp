import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppThemeMode { light, dark, system }

class AppTheme {
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final AppThemeMode themeMode;

  AppTheme({
    required this.lightTheme,
    required this.darkTheme,
    required this.themeMode,
  });

  AppTheme copyWith({
    AppThemeMode? themeMode,
  }) {
    return AppTheme(
      lightTheme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  static ThemeData getLightTheme() {
    return ThemeData(
      primarySwatch: Colors.indigo,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey[50],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: Colors.grey[800],
        displayColor: Colors.grey[800],
      ),
      cardTheme: CardTheme(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      primarySwatch: Colors.indigo,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[850],
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: Colors.grey[300],
        displayColor: Colors.grey[300],
      ),
      cardTheme: CardTheme(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      ),
    );
  }
}

class AppThemeNotifier extends StateNotifier<AppTheme> {
  AppThemeNotifier()
      : super(AppTheme(
    lightTheme: AppTheme.getLightTheme(),
    darkTheme: AppTheme.getDarkTheme(),
    themeMode: AppThemeMode.system,
  ));

  void toggleTheme() {
    state = state.copyWith(
      themeMode: switch (state.themeMode) {
        AppThemeMode.light => AppThemeMode.dark,
        AppThemeMode.dark => AppThemeMode.system,
        AppThemeMode.system => AppThemeMode.light,
      },
    );
  }
}

final appThemeProvider = StateNotifierProvider<AppThemeNotifier, AppTheme>((ref) {
  return AppThemeNotifier();
});