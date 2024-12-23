import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryBlue,
      scaffoldBackgroundColor: AppColors.backgroundWhite,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.iconGrey),
        titleTextStyle: TextStyle(
          fontFamily: AppFonts.montserrat,
          color: AppColors.textBlack,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: UnderlineInputBorder(
          borderSide:
              const BorderSide(width: 0.3, color: AppColors.primaryBlue),
          borderRadius: BorderRadius.circular(0),
        ),
        filled: true,
        fillColor: AppColors.backgroundGrey,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonBlue,
          foregroundColor: AppColors.backgroundWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontWeight: FontWeight.bold,
          color: AppColors.textBlack,
        ),
        bodyMedium: TextStyle(
            fontFamily: AppFonts.montserrat, color: AppColors.textGrey),
      ),
      iconTheme: const IconThemeData(color: AppColors.iconBlue),
      dividerColor: AppColors.borderGrey,
    );
  }
}
