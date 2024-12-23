// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_pro_user/controller/item_controller.dart';
import 'package:clean_pro_user/view/items/items_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:clean_pro_user/model/item_model.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';
import 'package:get/get.dart';

class ItemContentView extends StatefulWidget {
  List<ItemModelController?> items;
  String service;
  ItemContentView({
    super.key,
    required this.items,
    required this.service,
  });

  @override
  State<ItemContentView> createState() => _ItemContentViewState();
}

class _ItemContentViewState extends State<ItemContentView> {
  @override
  Widget build(BuildContext context) {
    print("service name is ${widget.service}");
    var itemController = Get.find<ItemController>();
    if (widget.items.isEmpty) {
      return Obx(() => ErrorWidget(
            error: itemController.error.value,
          ));
    } else {
      return ListView.separated(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          print("The service is ${widget.service}");
          var item = widget.items[index];
          Item itemModel = getService(widget.service, item!)["item"];
          double itemPrice = double.parse(
              getService(widget.service, item)["price"].toString());

          return ClothesListTile(
            name: item.item.name,
            description: '${widget.service} ',
            price: itemPrice,
            image: item.item.icon,
            quantity: item.count,
            onQuantityChanged: (newQuantity) {
              item.count = newQuantity;
              itemController.getTotalPrice(widget.service);
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      );
    }
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

class ClothesListTile extends StatefulWidget {
  final String name;
  final String description;
  final double price;
  final List<int> image;
  final int quantity;
  final Function(int) onQuantityChanged;

  const ClothesListTile({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  State<ClothesListTile> createState() => _ClothesListTileState();
}

class _ClothesListTileState extends State<ClothesListTile> {
  late TextEditingController count;
  late int currentQuantity;

  @override
  void initState() {
    super.initState();

    currentQuantity = widget.quantity;
    count = TextEditingController(text: '$currentQuantity');
  }

  @override
  void dispose() {
    count.dispose();
    super.dispose();
  }

  void updateQuantity(int newQuantity) {
    if (newQuantity >= 0) {
      setState(() {
        currentQuantity = newQuantity;
        count.text = '$currentQuantity';
      });
      widget.onQuantityChanged(currentQuantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundWhite,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Row(
            children: [
              SizedBox(
                width: 60,
                height: 80,
                child: Image(
                  image: MemoryImage(
                    Uint8List.fromList(widget.image),
                  ),
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.montserrat,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                widget.description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.actionBlue,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 15,
                            color: AppColors.actionBlue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '\$ ${widget.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.montserrat,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 24,
                height: 24,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: AppColors.actionBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      const Icon(Icons.remove, color: Colors.white, size: 12),
                  onPressed: () => updateQuantity(currentQuantity - 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: 32,
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                    ],
                    style: AppTextStyles.normalTextStyle,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: count,
                    onChanged: (value) {
                      int? newQuantity = int.tryParse(value);
                      if (newQuantity != null) {
                        updateQuantity(newQuantity);
                      }
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: AppColors.actionBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 12),
                  onPressed: () => updateQuantity(currentQuantity + 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

getService(String service, ItemModelController controller) {
  String a = service[0].toString();
  return a == "w"
      ? {"price": controller.item.prices.wash, "item": controller.item}
      : a == "d"
          ? {"price": controller.item.prices.dryClean, "item": controller.item}
          : {"price": controller.item.prices.iron, "item": controller.item};
}
