
import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';

class OrderPlacedPage extends StatelessWidget {
  const OrderPlacedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie.asset(
            //   'assets/animations/order_success.json',
            //   width: 200,
            //   height: 200,
            //   repeat: false,
            // ),
            const SizedBox(height: 32),
            Text(
              'Order Placed Successfully!',
              style: AppTextStyles.titleTextStyle.copyWith(
                fontSize: 24,
                color: AppColors.actionBlue,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Your order has been placed and will be processed soon. You will receive a confirmation email shortly.',
                textAlign: TextAlign.center,
                style: AppTextStyles.normalTextStyle.copyWith(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CustomElevatedButton(
                onPressed: () {
                  // Navigate to order tracking or home page
                  Get.offAllNamed('/home');
                },
                buttonText: 'Back to Home',
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Navigate to order details or tracking page
                Get.toNamed('/order-tracking');
              },
              child: Text(
                'Track Order',
                style: AppTextStyles.normalTextStyle.copyWith(
                  fontSize: 16,
                  color: AppColors.actionBlue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
