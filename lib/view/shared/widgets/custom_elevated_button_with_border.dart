import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_sizes.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButtonWithBorder extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const CustomElevatedButtonWithBorder(
      {super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.elevatdButtonHeight,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.backgroundWhite),
          foregroundColor: WidgetStateProperty.all(AppColors.primaryBlue),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(color: AppColors.primaryBlue),
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
