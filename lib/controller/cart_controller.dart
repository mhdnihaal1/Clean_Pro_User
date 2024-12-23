import 'package:clean_pro_user/controller/item_controller.dart';
import 'package:clean_pro_user/model/cart_model.dart';
import 'package:clean_pro_user/repository/cart_repo.dart';
import 'package:clean_pro_user/view/home/widgets/card_model.dart';
import 'package:get/get.dart';
import 'package:clean_pro_user/repository/auth_local_repo.dart';
import 'package:get/get_rx/get_rx.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  final CartRepository _cartRepository = CartRepository();
  ItemController itemController = Get.find<ItemController>();
  Rx<CartResponse?> cartResponse = Rx<CartResponse?>(null);
  RxBool isLoading = false.obs;
  RxBool isSecondLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<CartItemModel> cartModels = RxList([]);
  RxDouble totalPrice = RxDouble(0);

  @override
  onInit() {
    super.onInit();
    getCartItems();
  }

  Future<void> changeCartCount(
      {required String userId,
      required String service,
      required String itemId,
      required int count}) async {
    try {
      var res = await _cartRepository.changeCartQantity(
          userId: userId, service: service, itemId: itemId, count: count);

      print(res);
    } catch (e) {
      print(e);
      
      Get.snackbar('Error', 'An error occurred. Please try again.');
    }
  }

  Future<void> addToCart({
    required String userId,
    required String service,
    required List<CartItem> items,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _cartRepository.addToCart(
        userId: userId,
        service: service,
        items: items,
      );

      if (result['success'] == false) {
        itemController.resetPrice(service);
        Get.back();

        Get.snackbar('Success', result['message']);
      } else {
        Get.snackbar('Error', result['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCartItems({bool secondTme = false}) async {
    if (secondTme) {
      isSecondLoading.value = true;
    } else {
      isLoading.value = true;
    }
    errorMessage.value = '';

    try {
      final result = await _cartRepository.getCartItems();

      if (result != null && result['success'] == true) {
        cartResponse.value = CartResponse.fromJson(result['data']);
        cartModels.value = cartResponse.value!.data.cart.items;
        calcualteTotalPrice();
        Get.snackbar('Success', "sucess fully lodded items");
      } else {
        errorMessage.value = result?['message'] ?? 'Failed to fetch cart items';
        Get.snackbar('Error', errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = 'An error occurred. Please try again.';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      if (secondTme) {
        isSecondLoading.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  calcualteTotalPrice() {
    double price = 0;

    if (cartModels.value.isNotEmpty) {
      for (var e in cartModels.value) {
        // if(e.clothItem.category[0].toLowerCase()==)
        e.clothItem.prices.forEach(
          (key, value) {
            if (key.toLowerCase()[0] == e.clothItem.category[0].toLowerCase()) {
              price = price + (value * e.quantity);
            }
          },
        );
      }
    }
    totalPrice.value = price;
  }
}
