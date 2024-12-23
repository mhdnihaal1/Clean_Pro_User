// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';

class CustomPassWordFeild extends StatefulWidget {
  final TextEditingController passwordController;
  String lableText;
  String hintText;

  CustomPassWordFeild({
    this.lableText = 'Password',
    this.hintText = 'Enter your password',
    super.key,
    required this.passwordController,
  });
  @override
  State<CustomPassWordFeild> createState() => _CustomPassWordFeildState();
}

class _CustomPassWordFeildState extends State<CustomPassWordFeild> {
  bool _obscurePassword = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.password,
          color: AppColors.iconGrey,
        ),
        fillColor: AppColors.backgroundWhite,
        labelText: widget.lableText,
        hintText: widget.hintText,
        labelStyle: AppTextStyles.lableTextStyle,
        hintStyle: AppTextStyles.hintTextStyle,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textLightGrey, width: 0.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.actionBlue, width: 0.5),
        ),
        floatingLabelStyle: AppTextStyles.floatingLableTextStyle,
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: AppColors.textBlack,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      style: AppTextStyles.inputTextStyle,
    );
  }
}
