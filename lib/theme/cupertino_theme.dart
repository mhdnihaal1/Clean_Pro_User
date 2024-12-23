import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AppCupertinoTheme {
  static CupertinoThemeData get theme {
    return CupertinoThemeData(
      primaryColor: AppColors.primaryBlue,
      barBackgroundColor: AppColors.backgroundWhite,
      scaffoldBackgroundColor: AppColors.backgroundWhite,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.textBlack,
        navTitleTextStyle: TextStyle(
          color: AppColors.textBlack,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textStyle: TextStyle(
          color: AppColors.textGrey,
          fontSize: 16,
        ),
      ),
    );
  }

  static CupertinoNavigationBar getAppBar({required String title}) {
    return CupertinoNavigationBar(
      middle: Text(title),
      backgroundColor: AppColors.backgroundWhite,
      border: Border(bottom: BorderSide.none),
    );
  }

  static BoxDecoration getInputDecoration() {
    return BoxDecoration(
      color: AppColors.backgroundGrey,
      borderRadius: BorderRadius.circular(8),
    );
  }

  static ButtonStyle getPrimaryButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColors.buttonBlue),
      foregroundColor: MaterialStateProperty.all(AppColors.backgroundWhite),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  static Widget buildServiceCard({
    required String title,
    required IconData icon,
    required String duration,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.textGrey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40, color: AppColors.iconBlue),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textBlack)),
          Text(duration, style: TextStyle(color: AppColors.textGrey)),
        ],
      ),
    );
  }
}