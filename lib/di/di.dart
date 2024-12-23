import 'package:clean_pro_user/controller/auth_controller.dart';
import 'package:clean_pro_user/controller/cart_controller.dart';
import 'package:clean_pro_user/controller/item_controller.dart';
import 'package:clean_pro_user/controller/profile_controller.dart';
import 'package:clean_pro_user/repository/auth_local_repo.dart';
import 'package:get/get.dart';

class DependencyIngection {
  static init() {
    AuthLocalRepo authLocalRepo = Get.put(AuthLocalRepo());
    AuthController authController = Get.put(AuthController());
    ItemController itemController = Get.put(ItemController());
    CartController cartController = Get.put(CartController());
    ProfileController profileControler = Get.put(ProfileController());
  
  }
}
