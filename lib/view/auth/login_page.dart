import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:clean_pro_user/constants/app_sizes.dart';
import 'package:clean_pro_user/constants/image_paths.dart';
import 'package:clean_pro_user/controller/auth_controller.dart';
import 'package:clean_pro_user/view/auth/otp_page.dart';
import 'package:clean_pro_user/view/home/home_page.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_elevated_button.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_elevated_button_with_border.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_pass_word_feild.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Obx(() {
            if (authController.isLoading.value) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.actionBlue),
                      strokeWidth: 5,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Loading...',
                      style: TextStyle(
                        fontFamily: AppFonts.montserrat,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: AppSizes.height142,
                      child: Image.asset(
                        Images.washing,
                        color: AppColors.actionBlue,
                      ),
                    ),
                    SizedBox(height: AppSizes.height35),
                    const AppTitle(fontSize: 29),
                    SizedBox(height: AppSizes.height105),
                    const Text(
                      "Sign in now",
                      style: TextStyle(
                        fontFamily: AppFonts.montserrat,
                        fontSize: 25,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppSizes.height74),
                    CustomTextFeild(
                      prefix: Icons.email,
                      controller: emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                    SizedBox(height: AppSizes.height142),
                    // CustomPassWordFeild(passwordController: passwordController),
                    SizedBox(height: AppSizes.height74),
                    CustomElevatedButton(
                      onPressed: () {
                        Get.to(const HomePage());
                        authController.sendOtp(emailController.text);
                      },
                      buttonText: "Sign in",
                    ),
                    // SizedBox(height: AppSizes.height105),
                    // const Text(
                    //   "Not Registered yet?",
                    //   style: AppTextStyles.boldTextStyle,
                    //   textAlign: TextAlign.center,
                    // ),
                    // SizedBox(height: AppSizes.height74),
                    // CustomElevatedButtonWithBorder(
                    //   onPressed: () {
                    //     Get.to(const SignUpPage());
                    //   },
                    //   buttonText: 'Register Now',
                    // ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  final double fontSize;
  const AppTitle({
    required this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Clean",
          style: TextStyle(
            fontFamily: AppFonts.montserrat,
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
        Text(
          "Pro",
          style: TextStyle(
            fontFamily: AppFonts.openSans,
            fontSize: 29,
            fontWeight: FontWeight.w400,
            color: AppColors.textBlack,
          ),
        ),
      ],
    );
  }
}
