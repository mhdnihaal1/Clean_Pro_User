import 'dart:math';

import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/model/user_model.dart';
import 'package:clean_pro_user/network_handler/network_handler.dart';
import 'package:clean_pro_user/repository/auth_local_repo.dart';
import 'package:clean_pro_user/repository/auth_repo.dart';
import 'package:clean_pro_user/view/auth/login_page.dart';
import 'package:clean_pro_user/view/auth/register_page.dart';
import 'package:clean_pro_user/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepo _authRepo = AuthRepo();
  RxBool isLoggedIn = false.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxBool otpSent = false.obs;
  RxString userId = "".obs;

  



  Future<void> sendOtp(String email) async {
    isLoading.value = true;
    errorMessage.value = '';
    otpSent.value = false;
    email = email;

    try {
      await _authRepo.sentOtp(email);
      otpSent.value = true;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>?> verifyOtp(String otp, String email) async {
    print("email: $email");
    isLoading.value = true;
    errorMessage.value = '';
    otpSent.value = false;

    try {
      var response = await _authRepo.verifyOtp(email, otp);
      User? user;
      if (response?["success"]) {
        Get.snackbar('Success', 'OTP verified successfully');
        if (response!["data"] != null) {
          user = User.convertJsonToUser(response);
          if (user != null && !user.userStatus) {
            await AuthLocalRepo.storeToken(user.id);
            Get.offAll(const HomePage());
          } else {
            Get.snackbar(
              'Account Blocked',
              'Your account has been blocked. Please contact support for assistance.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.secondaryBlue,
              colorText: AppColors.backgroundWhite,
              duration: const Duration(seconds: 5),
              icon: const Icon(Icons.error_outline, color: Colors.white),
            );
          }
        }

        if (user == null) {
          Get.to(SignUpPage(email: email));
        }
        return {
          'success': true,
          'message': 'Entered OTP is correct',
          'data': response["data"]
        };
      } else {
        if (response?["message"] == 'OTP not found or has expired') {
          Get.snackbar('Error',
              'OTP not found or has expired. Please request a new OTP.');
        } else if (response?["message"] == 'Entered OTP is incorrect') {
          Get.snackbar('Error', 'Invalid OTP. Please try again.');
        } else {
          Get.snackbar(
              'Error', response?["message"] ?? 'Failed to verify OTP.');
        }
        return null;
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'An unexpected error occurred. Please try again later.');
      print(e);
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>?> signUp(
      String email, String name, String phone) async {
    try {
      isLoading.value = true;

      // Generate a random string for password

      Map<String, dynamic>? response = await _authRepo.signUp(
        email,
        name,
        phone,
      );

      print("res body $response");

      if (response!["success"]) {
        await AuthLocalRepo.storeToken(response["data"]["token"]);
        Get.to(const HomePage());
        return {
          'success': true,
          'message': 'New user created',
          'data': response["data"]
        };
      } else {
        if (response["message"] == 'User already exists') {
          Get.snackbar(
            'Error',
            'User already exists',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.actionRed,
            colorText: AppColors.backgroundWhite,
            duration: const Duration(seconds: 3),
            icon: const Icon(Icons.error_outline, color: Colors.white),
          );
        } else {
          Get.snackbar(
            'Error',
            'Sign up failed. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.actionRed,
            colorText: AppColors.backgroundWhite,
            duration: const Duration(seconds: 3),
            icon: const Icon(Icons.error_outline, color: Colors.white),
          );
        }
        return null;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.actionRed,
        colorText: AppColors.backgroundWhite,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      print(e);
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  String generateRandomPassword() {
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        12, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }
}
