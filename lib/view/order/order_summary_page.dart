import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:clean_pro_user/controller/cart_controller.dart';
import 'package:clean_pro_user/controller/order_contrller.dart';
import 'package:clean_pro_user/model/cart_model.dart';
import 'package:clean_pro_user/repository/auth_local_repo.dart';
import 'package:clean_pro_user/view/order/order_placed_page.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_elevated_button.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_elevated_button_with_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/profile_model.dart' as pmodel;
class OrderSummaryPage extends StatelessWidget {
  final pmodel. Address address;

  const  OrderSummaryPage({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    OrderController orderController = Get.put(OrderController());
    CartController cartController = Get.find<CartController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.actionBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Review Order',
          style: AppTextStyles.titleTextStyle.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Items',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.montserrat,
                      color: AppColors.actionBlue),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartController.cartModels.length,
                  itemBuilder: (context, index) {
                    CartItemModel item = cartController.cartModels[index];
                    double price = 0;
                    item.clothItem.prices.forEach(
                      (key, value) {
                        if (key
                            .toLowerCase()
                            .startsWith(item.service[0].toLowerCase())) {
                          price = double.parse(value.toString());
                        }
                      },
                    );

                    return OrderItem(
                      quantity: item.quantity,
                      item: item.clothItem.name,
                      service: item.service,
                      price: price ?? 0,
                    );
                  },
                ),
                const SizedBox(height: 32),
                const Text(
                  'Delivery Address',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.montserrat,
                      color: AppColors.actionBlue),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.street,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.montserrat),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${address.street}\n${address.city}, ${address.state} ${address.postalCode}',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButtonWithBorder(
                          buttonText: 'Change Address',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Amount',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryBlue)),
                      Text(
                          '\$${cartController.totalPrice.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBlue)),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Obx(
                  () {
                    print(
                        "order contrller is loding ${orderController.isLoading.value}");
                    print(
                        "order contrller error ${orderController.error.value}");
                    if (orderController.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.actionBlue,
                        ),
                      );
                    } else {
                      return CustomElevatedButton(
                          onPressed: () async {
                            String? userId = await AuthLocalRepo.getToken();
                            if (userId != null) {
                              orderController.confirmOrder(
                                  userId: userId,
                                  addressId: address.id,
                                  deliveryMode: "express");
                            }
                            if (orderController.isLoading == false &&
                                orderController.error.value.isEmpty) {
                              Get.to(const OrderPlacedPage());
                            }
                          },
                          buttonText: 'Confirm Order');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final int quantity;
  final String item;
  final String service;
  final double price;

  const OrderItem({
    super.key,
    required this.quantity,
    required this.item,
    required this.service,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$quantity x $item',
                  style: AppTextStyles.normalTextStyle
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  service,
                  style: AppTextStyles.lableTextStyle
                      .copyWith(color: AppColors.actionBlue, fontSize: 14),
                ),
              ],
            ),
          ),
          Text(
            '\$${(price * quantity).toStringAsFixed(2)}',
            style: AppTextStyles.normalTextStyle
                .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
