import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_finances_app/theme/colors.dart';
import 'package:personal_finances_app/theme/text_theme.dart';

/// Light theme configuration
///
/// Include inputDecorationTheme, textButtonTheme, elevatedButtonTheme
/// and colorScheme
final lightTheme = ThemeData(
  textTheme: appTextTheme,
  inputDecorationTheme: _inputDecorationThemeApp,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.primaryRed,
    selectionHandleColor: AppColors.secondaryGreen,
    selectionColor: Colors.blueAccent.withOpacity(0.4),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryRed,
      textStyle: GoogleFonts.mulish(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryBlack,
      foregroundColor: AppColors.primaryWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
    ),
  ),
  tabBarTheme: TabBarTheme(indicator: UnderlineTabIndicator()),
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryGreen,
    onPrimary: AppColors.primaryWhite,
    secondary: AppColors.secondaryGreen,
    onSecondary: AppColors.primaryWhite,
    tertiary: AppColors.primaryRed,
    onTertiary: AppColors.primaryBlack,
    error: AppColors.errorRed,
    background: AppColors.primaryWhite,
  ),
);

final _inputDecorationThemeApp = InputDecorationTheme(
  border: _borderInputDecoration,
  focusedBorder: _borderInputDecoration,
  enabledBorder: _borderInputDecoration,
  disabledBorder: _borderInputDecoration,
  fillColor: AppColors.primaryWhite,
  filled: true,
  isDense: true,
  isCollapsed: true,
  labelStyle: const TextStyle(
    color: AppColors.primaryBlack,
  ),
  iconColor: AppColors.primaryBlack,
  errorStyle: GoogleFonts.mulish(
    fontSize: 13,
    color: AppColors.errorRed,
  ),
);

final _borderInputDecoration = OutlineInputBorder(
  borderRadius: BorderRadius.circular(7),
  borderSide: const BorderSide(
    color: AppColors.primaryBlack,
  ),
);
