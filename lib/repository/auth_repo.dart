import 'package:clean_pro_user/network_handler/network_handler.dart';
import 'package:clean_pro_user/repository/auth_local_repo.dart';
import 'package:clean_pro_user/view/auth/otp_page.dart';
import 'package:clean_pro_user/view/home/home_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  
  sentOtp(String email) async {
    print("email form sent otp: $email");
    try {
      Map<String, dynamic> response =
          await NetworkHandler.post("sendOtp", {"email": email});

      if (response["success"]) {
        Get.snackbar('Success', 'OTP sent successfully');
        Get.to(OtpPage(
          email: email,
        ));
      } else {
        Get.snackbar('Error', 'Failed to send OTP. Please try again.');
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'An unexpected error occurred. Please try again later.');
      print(e);
    }
  }

  Future<Map<String, dynamic>?> verifyOtp(String email, String otp) async {
    try {
      Map<String, dynamic> response =
          await NetworkHandler.post("verifyOtp", {"otp": otp, "email": email});

      if (response["success"]) {
        Get.snackbar('Success', 'OTP verified successfully');

        return {
          'success': true,
          'message': 'Entered OTP is correct',
          'data': response["data"]
        };
      } else {
        if (response["message"] == 'OTP not found or has expired') {
          Get.snackbar('Error',
              'OTP not found or has expired. Please request a new OTP.');
        } else if (response["message"] == 'Entered OTP is incorrect') {
          Get.snackbar('Error', 'Invalid OTP. Please try again.');
        } else {
          Get.snackbar('Error', response["message"] ?? 'Failed to verify OTP.');
        }
        return null;
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'An unexpected error occurred. Please try again later.');
      print(e);
      return null;
    }
  }

  // Future<Map<String, dynamic>?> signUp(
  //     String email, String name, String phone, String password) async {
  //   try {
  //     Map<String, dynamic> response = await NetworkHandler.post("verifyOtp", {
  //       "name": name,
  //       "mobile": phone,
  //       "password": password,
  //       "email": email
  //     });
  //     print("res body $response");
  //     if (response["sucess"]) {
  //       Get.snackbar('Success', 'Sign up successful');
  //       return response;
  //     } else {
  //       Get.snackbar('Error', 'Sign up failed. Please try again.');
  //       return null;
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //         'Error', 'An unexpected error occurred. Please try again later.');
  //     print(e);
  //     return null;
  //   }
  // }

  Future<Map<String, dynamic>?> signUp(
      String email, String name, String phone) async {
    try {
      // Generate a random string for password
      String randomPassword = "slajfdl";

      Map<String, dynamic> response = await NetworkHandler.post("signup", {
        "name": name,
        "mobile": phone,
        "email": email,
        "password": randomPassword
      });

      print("res body $response");

      if (response["success"]) {
        Get.snackbar('Success', 'Sign up successful');

        await AuthLocalRepo.storeToken(response["data"]["_id"]);
        Get.to(const HomePage());
        return {
          'success': true,
          'message': 'New user created',
          'data': response["data"]
        };
      } else {
        if (response["message"] == 'User already exists') {
          Get.snackbar('Error', 'User already exists');
        } else {
          Get.snackbar('Error', 'Sign up failed. Please try again.');
        }
        return null;
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'An unexpected error occurred. Please try again later.');
      print(e);
      return null;
    }
  }
}
