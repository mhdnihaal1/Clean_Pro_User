import 'package:clean_pro_user/controller/auth_controller.dart';
import 'package:clean_pro_user/view/auth/register_page.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_elevated_button.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_otp_feild.dart';
import 'package:flutter/material.dart';
import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:get/get.dart';

class OtpPage extends StatelessWidget {
  String email;
  final TextEditingController otpController = TextEditingController();

  OtpPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your OTP has been sent to your email',
              style: TextStyle(
                fontFamily: AppFonts.montserrat,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textBlack,
              ),
            ),
            const SizedBox(height: 30),
            CustomOtpFeild(otpController: otpController),
            const SizedBox(height: 30),
            CustomElevatedButton(
                onPressed: () {
                  authController.verifyOtp(otpController.text, email);
                },
                buttonText: 'Verify'),
          ],
        ),
      ),
    );
  }
}
