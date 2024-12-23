import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class CustomOtpFeild extends StatelessWidget {
  TextEditingController otpController;

  CustomOtpFeild({required this.otpController, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: otpController,
      maxLength: 6,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        fillColor: AppColors.backgroundWhite,
        hintText: 'Enter Otp',
        hintStyle: TextStyle(
          fontSize: 18,
          fontFamily: AppFonts.montserrat,
          fontWeight: FontWeight.w200,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textLightGrey, width: 1.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textLightGrey, width: 1.6),
        ),
        counterText: '',
      ),
      style: const TextStyle(
        fontFamily: AppFonts.montserrat,
        fontSize: 24,
        letterSpacing: 0,
      ),
    );
  }
}
