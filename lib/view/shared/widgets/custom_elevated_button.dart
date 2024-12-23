import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:clean_pro_user/constants/app_sizes.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const CustomElevatedButton(
      {super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.elevatdButtonHeight,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.primaryBlue),
          foregroundColor: WidgetStateProperty.all(AppColors.backgroundWhite),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: AppTextStyles.buttonTextStyle,
        ),
      ),
    );
  }
}
