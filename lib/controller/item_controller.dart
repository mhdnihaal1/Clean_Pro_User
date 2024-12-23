import 'package:get/get.dart';

import 'package:clean_pro_user/model/item_model.dart';
import 'package:clean_pro_user/network_handler/network_handler.dart';

class ItemController extends GetxController {
  var items = <Item>[].obs;
  var categories = <Category>[].obs;
  RxList<ItemModelController> itemControllers = <ItemModelController>[].obs;

  Rx<double> totalPrice = 0.0.obs;
  Rx<bool> isLoading = false.obs;

  RxString error = RxString("");

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      isLoading.value = true;
      final result = await ItemRepo.getItems();
      if (result != null) {
        categories.value = result;
        items.value = result.expand((category) => category.items).toList();
        itemControllers.value = items.map((item) {
          return ItemModelController(item: item);
        }).toList();
      }
    } catch (e) {
      error.value = e.toString();
      return;
    } finally {
      isLoading.value = false;
    }
  }

  double getTotalPrice(String servic) {
    double price = 0;
    for (var item in itemControllers) {
      price += getPrince(servic, item.item) * item.count;
    }

    totalPrice.value = price;
    return totalPrice.value;
  }

  double resetPrice(String servic) {
    double price = 0;
    for (var item in itemControllers) {
      item.count = 0;
    }

    totalPrice.value = price;
    return totalPrice.value;
  }
}

class ItemRepo {
  static List<Item> items = [];

  static Future<List<Category>?> getItems() async {
    try {
      final res = await NetworkHandler.get("getItems");
      List<Category> cat = Category.convertJsonToCategories(res);
      return cat;
    } catch (e) {
      print('Error in getItems: $e');
      rethrow;
    }
  }
}

getPrince(String service, Item item) {
  if (service[0].toLowerCase() == "w") {
    return item.prices.wash;
  }
  if (service[0].toLowerCase() == "i") {
    return item.prices.iron;
  }
  if (service[0].toLowerCase() == "d") {
    return item.prices.dryClean;
  }

  return 0;
}
