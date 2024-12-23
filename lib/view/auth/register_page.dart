import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:clean_pro_user/constants/app_sizes.dart';
import 'package:clean_pro_user/constants/image_paths.dart';
import 'package:clean_pro_user/controller/auth_controller.dart';
import 'package:clean_pro_user/view/auth/login_page.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_elevated_button.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  String email;
  SignUpPage({super.key, required this.email});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _seconNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.backgroundWhite,
        surfaceTintColor: AppColors.backgroundWhite,
        backgroundColor: AppColors.backgroundWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
                "Register now",
                style: TextStyle(
                  fontFamily: AppFonts.montserrat,
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                  color: AppColors.textBlack,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: AppSizes.height54),
              CustomTextFeild(
                controller: _nameController,
                labelText: 'First Name',
                hintText: 'Enter your First name',
                prefix: Icons.person,
              ),
              SizedBox(height: AppSizes.height54),
              CustomTextFeild(
                controller: _seconNameController,
                labelText: 'Last name Name ',
                hintText: 'Enter Last name (optional)',
                prefix: Icons.person,
              ),
              // SizedBox(height: AppSizes.height54),
              // CustomTextFeild(
              //   controller: _emailController,
              //   labelText: 'Email',
              //   hintText: 'Enter your email',
              //   prefix: Icons.email,
              // ),
              SizedBox(height: AppSizes.height54),
              CustomTextFeild(
                maxLength: 10,
                controller: _phoneNumberController,
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                prefix: Icons.phone,
              ),
              SizedBox(height: AppSizes.height35),
              // CustomPassWordFeild(
              //   passwordController: _passwordController,
              // ),
              // SizedBox(height: AppSizes.height35),
              // CustomPassWordFeild(
              //   hintText: "Confirm Password",
              //   lableText: "Confirm Password",
              //   passwordController: _confirmPasswordController,
              // ),
              SizedBox(height: AppSizes.height105),
              SizedBox(height: AppSizes.height105),
              SizedBox(height: AppSizes.height35),
              CustomElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty ||
                      _phoneNumberController.text.isNotEmpty) {
                    AuthController authController = AuthController();
                    authController.signUp(
                        widget.email,
                        "${_nameController.text} ${_seconNameController.text}",
                        _phoneNumberController.text);
                  }
                },
                buttonText: "Sign Up",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
