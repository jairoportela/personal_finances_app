import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_finances_app/theme/colors.dart';

///TextTheme configuration include:
///
///headline6, subtitle1, subtitle2, bodyText2, button
TextTheme appTextTheme = TextTheme(
  headline6: GoogleFonts.mulish(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryBlack,
  ),
  subtitle1: GoogleFonts.mulish(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryBlack,
  ),
  subtitle2: GoogleFonts.mulish(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryBlack,
  ),
  bodyText1: GoogleFonts.mulish(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryBlack,
  ),
  bodyText2: GoogleFonts.mulish(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryBlack,
  ),
  button: GoogleFonts.mulish(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryBlack,
  ),
);
