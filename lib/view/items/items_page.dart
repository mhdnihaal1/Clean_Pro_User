import 'dart:math';

import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:clean_pro_user/controller/cart_controller.dart';
import 'package:clean_pro_user/controller/item_controller.dart';
import 'package:clean_pro_user/model/item_model.dart';
import 'package:clean_pro_user/repository/cart_repo.dart';
import 'package:clean_pro_user/repository/auth_local_repo.dart';
import 'package:clean_pro_user/view/items/widgets/item_content_view.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsPage extends StatefulWidget {
  final String service;
  const ItemsPage({super.key, required this.service});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> with TickerProviderStateMixin {
  late TabController controller;
  final ItemController itemController = Get.put(ItemController());
  @override
  void initState() {
    print("the service from itemPagre is  ${widget.service}");
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ItemController itemController = Get.find<ItemController>();
    CartController cartController = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.actionBlue,
        title: const Text(
          "Select Clothes",
          style: AppTextStyles.titleTextStyle,
        ),
        bottom: TabBar(
          controller: controller,
          labelColor: AppColors.actionBlue,
          indicatorColor: AppColors.actionBlue,
          tabs: const [
            Tab(
                child: Text(
              "Men",
              style: AppTextStyles.normalTextStyle,
            )),
            Tab(
                child: Text(
              "Women",
              style: AppTextStyles.normalTextStyle,
            )),
            Tab(
                child: Text(
              "Kids",
              style: AppTextStyles.normalTextStyle,
            )),
            Tab(
                child: Text(
              "Others",
              style: AppTextStyles.normalTextStyle,
            )),
          ],
        ),
      ),
      body: Container(
        child: Obx(
          () {
            if (cartController.isLoading.value ||
                itemController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.actionBlue,
                ),
              );
            }

            // if (cartController.error.value.isNotEmpty) {
            //   Get.snackbar(
            //     'Error',
            //     cartController.errorMessage.value,
            //     snackPosition: SnackPosition.BOTTOM,
            //     backgroundColor: Colors.red,
            //     colorText: Colors.white,
            //     duration: const Duration(seconds: 3),
            //   );
            //   return const SizedBox.shrink();
            // }
            return Stack(
              children: [
                TabBarView(
                  controller: controller,
                  children: [
                    ItemContentView(
                      items: getItem("men"),
                      service: widget.service,
                    ),
                    ItemContentView(
                      items: getItem("women"),
                      service: widget.service,
                    ),
                    ItemContentView(
                      items: getItem("kids"),
                      service: widget.service,
                    ),
                    ItemContentView(
                      items: getItem("others"),
                      service: widget.service,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Obx(
                    () => Container(
                      width: double.infinity,
                      height: 60,
                      color: AppColors.actionBlue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Total \$ ${itemController.totalPrice}",
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.white,
                          ),
                          InkWell(
                            onTap: () async {
                              var cartController = Get.find<CartController>();
                              String userId =
                                  await AuthLocalRepo.getToken() ?? "";
                              if (userId.isNotEmpty) {
                                List<CartItem> cartItems = [];
                                for (var element
                                    in itemController.itemControllers) {
                                  if (element.count != 0) {
                                    cartItems.add(CartItem(
                                        itemId: element.item.id,
                                        quantity: element.count));
                                  }
                                }
                                cartController.addToCart(
                                    userId: userId,
                                    service: widget.service,
                                    items: cartItems);
                              }
                            },
                            child: Text(
                              "Add to cart",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: itemController.totalPrice.toInt() == 0
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.white,
                                  fontFamily: AppFonts.montserrat),
                            ),
                          )
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

getItem(String service) {
  ItemController itemController = Get.find<ItemController>();
  print("items are::  ${itemController.items.value.toString()}");
  List<ItemModelController> items = [];

  for (var element in itemController.itemControllers) {
    print("Service form getitems $service  ${element.item.category}");
    if (element.item.category.toLowerCase() == service.toLowerCase()) {
      items.add(element);
    }
  }

  return items;
}
