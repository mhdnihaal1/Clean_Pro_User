// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';

class CustomTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefix;
  int maxLength;

  CustomTextFeild(
      {super.key,
      this.maxLength = 1000,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.prefix});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: AppColors.iconGrey,
        ),
        fillColor: AppColors.backgroundWhite,
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(
          fontFamily: AppFonts.montserrat,
          fontWeight: FontWeight.w100,
        ),
        hintStyle: const TextStyle(
          fontFamily: AppFonts.montserrat,
          fontWeight: FontWeight.w100,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textLightGrey, width: 0.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.actionBlue, width: 0.5),
        ),
        floatingLabelStyle: const TextStyle(
            color: AppColors.actionBlue, fontWeight: FontWeight.w600),
        counterText: '',
      ),
      style: const TextStyle(fontFamily: AppFonts.montserrat),
    );
  }
}
