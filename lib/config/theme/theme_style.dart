import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const MaterialColor primarySwatch =
      MaterialColor(_primarySwatchPrimaryValue, <int, Color>{
        50: Color(0xFFE9F6FE),
        100: Color(0xFFcefdff),
        200: Color(0xFFa2f8ff),
        300: Color(0xFF63f0fd),
        400: Color(0xFF1cdef4),
        500: Color(_primarySwatchPrimaryValue),
        600: Color(0xFF039ab7),
        700: Color(0xFF0a7a94),
        800: Color(0xFF126278),
        900: Color(0xFF145265),
      });

  static const int _primarySwatchPrimaryValue = 0xFF00BBD3;

  static const MaterialColor secondarySwatch =
      MaterialColor(_secondarySwatchPrimaryValue, <int, Color>{
        50: Color(0xFFeffefc),
        100: Color(0xFFc8fff7),
        200: Color(0xFF92fdf1),
        300: Color(0xFF53f5e8),
        400: Color(0xFF33e4db),
        500: Color(_primarySwatchPrimaryValue),
        600: Color(0xFF029f9d),
        700: Color(0xFF077e7e),
        800: Color(0xFF0b6364),
        900: Color(0xFF0e5353),
      });
  static const int _secondarySwatchPrimaryValue = 0xFF33E4DB;

  static final ColorScheme _lightScheme =
      ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: primarySwatch,
        backgroundColor: AppColors.background,
      ).copyWith(
        primary: primarySwatch[900],
        secondary: primarySwatch[500],
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black87,
        error: Colors.red.shade700,
        onError: Colors.white,
      );

  static final TextTheme _textTheme = GoogleFonts.leagueSpartanTextTheme()
      .copyWith(
        headlineLarge: GoogleFonts.leagueSpartan(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: _lightScheme.onPrimary,
        ),
        titleLarge: GoogleFonts.leagueSpartan(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: _lightScheme.onSurface,
        ),
        labelLarge: GoogleFonts.leagueSpartan(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: _lightScheme.onPrimary,
        ),
        bodyMedium: GoogleFonts.leagueSpartan(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: _lightScheme.onSurface,
        ),
      );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _lightScheme,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: GoogleFonts.leagueSpartan().fontFamily,

    appBarTheme: AppBarTheme(
      backgroundColor: AppTheme.primarySwatch[900],
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.white,
      toolbarHeight: 56,
    ),

    iconTheme: IconThemeData(color: _lightScheme.onPrimary),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 3,
      shadowColor: AppColors.cardShadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.zero,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primarySwatch[100]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primarySwatch),
      ),
      hintStyle: TextStyle(color: Colors.grey.shade600),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primarySwatch[700],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),

    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      tileColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      horizontalTitleGap: 12,
    ),

    shadowColor: AppColors.cardShadow,

    textTheme: _textTheme,
  );

  static final ColorScheme _darkScheme =
      ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: primarySwatch,
        backgroundColor: const Color(0xFF121212),
      ).copyWith(
        primary: primarySwatch[400],
        secondary: primarySwatch[200],
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        surface: const Color(0xFF1E1E1E),
        onSurface: Colors.white.withValues(alpha: .87),
        error: Colors.red.shade400,
        onError: Colors.black,
      );

  static final TextTheme _darkTextTheme = GoogleFonts.leagueSpartanTextTheme()
      .copyWith(
        headlineLarge: GoogleFonts.leagueSpartan(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: _darkScheme.onPrimary,
        ),
        titleLarge: GoogleFonts.leagueSpartan(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: _darkScheme.onSurface,
        ),
        labelLarge: GoogleFonts.leagueSpartan(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: _darkScheme.onPrimary,
        ),
        bodyMedium: GoogleFonts.leagueSpartan(
          fontSize: 14,
          color: _darkScheme.onSurface,
        ),
      );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: _darkScheme,
    scaffoldBackgroundColor: _darkScheme.onPrimary,
    fontFamily: GoogleFonts.leagueSpartan().fontFamily,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.white,
    ),

    iconTheme: IconThemeData(color: _darkScheme.onSurface),

    cardTheme: CardThemeData(
      color: _darkScheme.surface,
      elevation: 2,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.zero,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primarySwatch[400]!),
      ),
      hintStyle: TextStyle(color: Colors.white60),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primarySwatch[400],
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),

    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      tileColor: _darkScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      horizontalTitleGap: 12,
    ),

    shadowColor: Colors.black45,
    textTheme: _darkTextTheme,
  );
}

class AppColors {
  AppColors._();

  static const background = Color(0xFFF5F7FA);
  static const Color cardShadow = Colors.black12;
  static const blur = Color(0xFFe1ecff);
  static var splash = const Color(0xFF063455);
  static var redColor = const Color.fromARGB(255, 175, 12, 0);
  static var green = Colors.green.shade800;
  static const white = Colors.white;
  static const darkColor = Color.fromRGBO(35, 52, 95, 1);
  static const darkColorLight = Color.fromRGBO(57, 77, 127, 1);
  static const darkIconColor = Color.fromRGBO(72, 113, 196, 1);
  static const greyBlue = Color(0xFF677A8A);
  static const grey = Color(0xFFCDCDCD);
  static const blackGrey = Color(0xFF323738);
}

class AppTextStyle {
  AppTextStyle._();

  static TextStyle battamBong14({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      fontFamily: 'Battambang',
      color: color ?? AppColors.white,
    );
  }

  static TextStyle battamBong15({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 15,
      fontFamily: 'Battambang',
      color: color ?? AppColors.white,
    );
  }

  static TextStyle battamBong16({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      fontFamily: 'Battambang',
      color: color ?? AppColors.white,
    );
  }

  static TextStyle battamBong18({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      fontFamily: 'Battambang',
      color: color ?? AppColors.white,
    );
  }

  static TextStyle battamBongBold18({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      fontFamily: 'Battambang-Bold',
      color: color ?? AppColors.white,
    );
  }

  static TextStyle battamBongBold16({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      fontFamily: 'Battambang-Bold',
      color: color ?? AppColors.white,
    );
  }

  static TextStyle battamBongBold20({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 20,
      fontFamily: 'Battambang-Bold',
      color: color ?? AppColors.white,
    );
  }

  static TextStyle battamBong20({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 20,
      fontFamily: 'Battambang',
      color: color ?? AppColors.white,
    );
  }

  static TextStyle regular10({
    double? height,
    Color? color,
    bool? underline,
    String? fontFamily,
  }) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      height: height,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Regular'
              : 'Battambang'),
      decoration: underline == true
          ? TextDecoration.underline
          : TextDecoration.none,
      fontSize: Get.locale == const Locale('en', 'US') ? 10 : 10,
      color: color ?? Colors.black,
    );
  }

  static TextStyle regular11({
    double? height,
    Color? color,
    bool? underline,
    String? fontFamily,
  }) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      height: height,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Regular'
              : 'Battambang'),
      decoration: underline == true
          ? TextDecoration.underline
          : TextDecoration.none,
      fontSize: Get.locale == const Locale('en', 'US') ? 11 : 11,
      color: color ?? Colors.black,
    );
  }

  static TextStyle regular12({
    double? height,
    Color? color,
    bool? underline,
    String? fontFamily,
  }) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      height: height,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Regular'
              : 'Battambang'),
      decoration: underline == true
          ? TextDecoration.underline
          : TextDecoration.none,
      fontSize: Get.locale == const Locale('en', 'US') ? 14 : 12,
      color: color ?? Colors.black,
    );
  }

  static TextStyle regular13({
    double? height,
    Color? color,
    bool? underline,
    String? fontFamily,
  }) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      height: height,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Regular'
              : 'Battambang'),
      decoration: underline == true
          ? TextDecoration.underline
          : TextDecoration.none,
      fontSize: Get.locale == const Locale('en', 'US') ? 15 : 13,
      color: color ?? Colors.black,
    );
  }

  static TextStyle regular14({
    double? height,
    Color? color,
    bool? underline,
    String? fontFamily,
  }) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      height: height,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Regular'
              : 'Battambang'),
      decoration: underline == true
          ? TextDecoration.underline
          : TextDecoration.none,
      fontSize: Get.locale == const Locale('en', 'US') ? 14 : 14,
      color: color ?? Colors.black,
    );
  }

  static TextStyle regular14s({
    double? height,
    Color? color,
    bool? underline,
    String? fontFamily,
  }) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      height: height,
      fontFamily: 'SourceSansPro-Regular',
      decoration: underline == true
          ? TextDecoration.underline
          : TextDecoration.none,
      fontSize: 14,
      color: color ?? Colors.black,
    );
  }

  static TextStyle regular16({
    Color? color,
    double? height,
    String? fontFamily,
    bool? underline,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      decoration: underline == true ? TextDecoration.underline : null,
      fontWeight: FontWeight.normal,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontSize: Get.locale == const Locale('en', 'US') ? 16 : 16,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Regular'
              : 'Battambang'),
      color: color ?? Colors.black,
      height: height,
    );
  }

  static TextStyle regular17({
    Color? color,
    double? height,
    String? fontFamily,
    bool? underline,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      decoration: underline == true ? TextDecoration.underline : null,
      fontWeight: FontWeight.normal,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontSize: Get.locale == const Locale('en', 'US') ? 17 : 17,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Regular'
              : 'Battambang'),
      color: color ?? Colors.black,
      height: height,
    );
  }

  static TextStyle regular16NoKhmer({
    Color? color,
    double? height,
    String? fontFamily,
  }) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      fontFamily: 'SourceSansPro-Regular',
      color: color ?? Colors.black,
      height: height,
    );
  }

  static TextStyle regular15({
    Color? color,
    double? height,
    bool? underline,
    String? fontFamily,
  }) {
    return TextStyle(
      decoration: underline == true ? TextDecoration.underline : null,
      fontWeight: FontWeight.normal,
      fontSize: Get.locale == const Locale('en', 'US') ? 15 : 15,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Regular'
              : 'Battambang'),
      color: color ?? Colors.black,
      height: height,
    );
  }

  static TextStyle regular18({
    Color? color,
    double? height,
    String? fontFamily,
  }) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: Get.locale == const Locale('en', 'US') ? 18 : 18,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Regular'
              : 'Battambang'),
      color: color ?? Colors.black,
      height: height,
    );
  }

  static TextStyle regular19({
    Color? color,
    double? height,
    String? fontFamily,
  }) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: Get.locale == const Locale('en', 'US') ? 18 : 16,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Regular'
              : 'Battambang'),
      color: color ?? Colors.black,
      height: height,
    );
  }

  static TextStyle regular20({
    Color? color,
    double? height,
    String? fontFamily,
  }) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: Get.locale == const Locale('en', 'US') ? 20 : 20,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Regular'
              : 'Battambang'),
      color: color ?? Colors.black,
      height: height,
    );
  }

  static TextStyle regular22({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 22,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle regular24({Color? color, double? height}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 24,
      color: color ?? AppColors.white,
      height: height,
    );
  }

  static TextStyle regular28({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 28,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle medium14({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle medium16({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle medium18({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle medium28({Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 28,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold14({Color? color, double? height, String? fontFamily}) {
    return TextStyle(
      height: height,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Bold'
              : 'Battambang-Bold'),
      fontWeight: FontWeight.bold,
      fontSize: Get.locale == const Locale('en', 'US') ? 14 : 13,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold15({Color? color, double? height, String? fontFamily}) {
    return TextStyle(
      height: height,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Bold'
              : 'Battambang-Bold'),
      fontWeight: FontWeight.bold,
      fontSize: Get.locale == const Locale('en', 'US') ? 15 : 14,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold14NoKh({
    Color? color,
    double? height,
    String? fontFamily,
  }) {
    return TextStyle(
      height: height,
      fontFamily: fontFamily ?? 'SourceSansPro-Bold',
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold10({Color? color}) {
    return TextStyle(
      fontFamily: 'SourceSansPro-Bold',
      fontSize: 10,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold5({Color? color}) {
    return TextStyle(
      fontFamily: 'SourceSansPro-Bold',
      fontSize: 5,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold12({Color? color, double? height, String? fontFamily}) {
    return TextStyle(
      height: height,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Bold'
              : 'Battambang-Bold'),
      fontWeight: FontWeight.bold,
      fontSize: Get.locale == const Locale('en', 'US') ? 12 : 12,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold17({Color? color, double? height, String? fontFamily}) {
    return TextStyle(
      height: height,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Bold'
              : 'Battambang-Bold'),
      fontWeight: FontWeight.bold,
      fontSize: Get.locale == const Locale('en', 'US') ? 17 : 15,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold18({Color? color, double? height, String? fontFamily}) {
    return TextStyle(
      height: height,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Bold'
              : 'Battambang-Bold'),
      fontWeight: FontWeight.bold,
      fontSize: Get.locale == const Locale('en', 'US') ? 18 : 18,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold16({Color? color, double? height, String? fontFamily}) {
    return TextStyle(
      height: height,
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Bold'
              : 'Battambang-Bold'),
      fontWeight: FontWeight.bold,
      fontSize: Get.locale == const Locale('en', 'US') ? 16 : 14,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold13({Color? color}) {
    return TextStyle(
      fontFamily: 'SourceSansPro-Bold',
      fontSize: 13,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold19({Color? color, double? height}) {
    return TextStyle(
      fontFamily: 'SourceSansPro-Bold',
      height: height,
      fontSize: 19,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold20({Color? color, String? fontFamily}) {
    return TextStyle(
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Bold'
              : 'Battambang-Bold'),
      fontSize: Get.locale == const Locale('en', 'US') ? 20 : 20,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold22({Color? color, String? fontFamily}) {
    return TextStyle(
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Bold'
              : 'Battambang-Bold'),
      fontSize: Get.locale == const Locale('en', 'US') ? 22 : 19,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold24({Color? color, String? fontFamily}) {
    return TextStyle(
      fontFamily: fontFamily ?? 'SourceSansPro-Bold',
      fontSize: 24,
      color: color ?? AppColors.white,
    );
  }

  static TextStyle bold26({Color? color, String? fontFamily}) {
    return TextStyle(
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Bold'
              : 'Battambang-Bold'),
      fontSize: Get.locale == const Locale('en', 'US') ? 26 : 20,
      color: color ?? Colors.black,
    );
  }

  static TextStyle bold28({Color? color, String? fontFamily}) {
    return TextStyle(
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Bold'
              : 'Battambang-Bold'),
      fontSize: Get.locale == const Locale('en', 'US') ? 28 : 22,
      color: color ?? Colors.black,
    );
  }

  static TextStyle bold35({Color? color, String? fontFamily}) {
    return TextStyle(
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Bold'
              : 'Battambang-Bold'),
      fontSize: Get.locale == const Locale('en', 'US') ? 35 : 25,
      color: color ?? Colors.black,
    );
  }

  static TextStyle bold25({Color? color, String? fontFamily}) {
    return TextStyle(
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Bold'
              : 'Battambang-Bold'),
      fontSize: Get.locale == const Locale('en', 'US') ? 25 : 25,
      color: color ?? Colors.black,
    );
  }

  static TextStyle bold40({Color? color, String? fontFamily}) {
    return TextStyle(
      fontFamily:
          fontFamily ??
          (Get.locale == const Locale('en', 'US')
              ? 'SourceSansPro-Bold'
              : 'Battambang-Bold'),
      fontSize: Get.locale == const Locale('en', 'US') ? 40 : 30,
      color: color ?? Colors.black,
    );
  }

  static TextStyle bold50({Color? color, String? fontFamily}) {
    return TextStyle(
      fontFamily: fontFamily ?? 'SourceSansPro-Bold',
      fontSize: 50,
      color: color ?? AppColors.white,
    );
  }
}
