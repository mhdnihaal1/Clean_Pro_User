import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:clean_pro_user/controller/cart_controller.dart';
import 'package:clean_pro_user/repository/cart_repo.dart';
import 'package:clean_pro_user/view/address/add_address.dart';
import 'package:clean_pro_user/view/cart/cart_content_view.dart';
import 'package:clean_pro_user/view/items/widgets/item_content_view.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  final String service;
  const CartPage({super.key, required this.service});

  @override
  State<CartPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<CartPage> with TickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    // CartRepository().getCartItems();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete Address',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
          content: const Text(
            'Do you want to delete this address?',
            style: AppTextStyles.normalTextStyle,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.backgroundWhite,
          elevation: 8,
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.secondaryBlue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.actionRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Perform delete operation here
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var cartConroller = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.actionBlue,
        title: const Text(
          "Your Cart",
          style: AppTextStyles.titleTextStyle,
        ),
        bottom: TabBar(
          controller: controller,
          labelColor: AppColors.actionBlue,
          indicatorColor: AppColors.actionBlue,
          tabs: const [
            Tab(
                child: Text(
              "Wash",
              style: AppTextStyles.normalTextStyle,
            )),
            Tab(
                child: Text(
              "Iron",
              style: AppTextStyles.normalTextStyle,
            )),
            Tab(
                child: Text(
              "Dry Clean",
              style: AppTextStyles.normalTextStyle,
            )),
          ],
        ),
      ),
      body: Container(
        child: Obx(
          () {
            if (cartConroller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.actionBlue,
                ),
              );
            }

            return Stack(
              children: [
                TabBarView(
                  controller: controller,
                  children: [
                    CartContentView(
                        items: cartConroller.cartModels
                            .where((p0) =>
                                p0.service.toLowerCase().startsWith("w"))
                            .toList(),
                        service: "wash"),
                    CartContentView(
                        items: cartConroller.cartModels
                            .where((p0) =>
                                p0.service.toLowerCase().startsWith("i"))
                            .toList(),
                        service: "Iron"),
                    CartContentView(
                        items: cartConroller.cartModels
                            .where((p0) =>
                                p0.service.toLowerCase().startsWith("d"))
                            .toList(),
                        service: "Dry Clean"),
                  ],
                ),
                Obx(
                  () => Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      color: AppColors.actionBlue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cartConroller.isSecondLoading.value
                              ? const CircularProgressIndicator(
                                  color: AppColors.backgroundWhite,
                                )
                              : Text(
                                  "Total \$ ${cartConroller.totalPrice} ",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.white,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(const AddAddress());
                            },
                            child: const Text(
                              "Order now",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: AppFonts.montserrat),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
