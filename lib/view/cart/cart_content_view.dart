import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/controller/cart_controller.dart';
import 'package:clean_pro_user/controller/profile_controller.dart';
import 'package:clean_pro_user/model/cart_model.dart';
import 'package:clean_pro_user/repository/cart_repo.dart';
import 'package:clean_pro_user/view/items/widgets/item_content_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/styles/text_styles/app_font_styles.dart';

class CartContentView extends StatefulWidget {
  final List<CartItemModel?> items;
  final String service;
  const CartContentView({
    super.key,
    required this.items,
    required this.service,
  });

  @override
  State<CartContentView> createState() => _CartContentViewState();
}

class _CartContentViewState extends State<CartContentView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundGrey,
      child: Obx(
        () {
          print("service name is ${widget.service}");
          var itemController = Get.find<CartController>();
          if (itemController.errorMessage.value.isNotEmpty) {
            return Obx(() => ErrorWidget(
                  error: itemController.errorMessage.value,
                ));
          } else if (widget.items.isEmpty) {
            return const Center(
              child: Text("No items in cart"),
            );
          } else {
            return ListView.separated(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                print("The service is ${widget.service}");
                var item = widget.items[index];

                double price = 0;
                item!.clothItem.prices.forEach(
                  (key, value) {
                    if (key
                        .toLowerCase()
                        .startsWith(item.service[0].toLowerCase())) {
                      price = double.parse(value.toString());
                    }
                  },
                );

                return ClothesListTile(
                  name: item.clothItem.name,
                  description: '${widget.service} ',
                  price: price,
                  image: item.clothItem.icon,
                  quantity: item.quantity,
                  onQuantityChanged: (newQuantity) async {
                    item.quantity = newQuantity;
                    CartController cartController = Get.find<CartController>();
                    Cart cart = cartController.cartResponse.value!.data.cart;
                    ProfileController profileController =
                        Get.find<ProfileController>();
                    await cartController.changeCartCount(
                        userId: cart.userId,
                        service: widget.service,
                        itemId: item.id,
                        count: newQuantity);
                    itemController.calcualteTotalPrice();

                    cartController.getCartItems(secondTme: true);
                    // itemController.getTotalPrice(widget.service);
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            );
          }
        },
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Text(
        error.isEmpty
            ? "No Items Found"
            : 'something went wrong. check your internet connection !',
        style: AppTextStyles.titleTextStyle,
        textAlign: TextAlign.center,
      )),
    );
  }
}


// getService(String service, CartItemModel controller) {
//   String a = service[0].toString();
//   return a == "w"
//       ? {"price": controller.clothItem.prices., "item": controller.item}
//       : a == "d"
//           ? {"price": controller.item.prices.dryClean, "item": controller.item}
//           : {"price": controller.item.prices.iron, "item": controller.item};
// }