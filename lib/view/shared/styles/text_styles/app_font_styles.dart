import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  //text feild text styles
  static const TextStyle lableTextStyle = TextStyle(
    fontFamily: AppFonts.montserrat,
    fontWeight: FontWeight.w100,
  );
  static const TextStyle hintTextStyle = TextStyle(
    fontFamily: AppFonts.montserrat,
    fontWeight: FontWeight.w100,
  );
  static const TextStyle floatingLableTextStyle =
      TextStyle(color: AppColors.actionBlue, fontWeight: FontWeight.w600);
  static const TextStyle inputTextStyle =
      TextStyle(fontFamily: AppFonts.montserrat);

  //button textstyles
  static const TextStyle buttonTextStyle =
      TextStyle(fontFamily: AppFonts.montserrat, fontSize: 16);

  //normal text styles
  static const TextStyle boldTextStyle = TextStyle(
    color: AppColors.textBlack,
    fontFamily: AppFonts.montserrat,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  static const TextStyle titleTextStyle = TextStyle(
    color: AppColors.textBlack,
    fontFamily: AppFonts.montserrat,
    fontWeight: FontWeight.w300,
    fontSize: 22,
  );

  static const TextStyle normalTextStyle = TextStyle(
    fontFamily: AppFonts.montserrat,
    fontWeight: FontWeight.w700,
  );
}



