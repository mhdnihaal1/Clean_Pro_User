import 'package:clean_pro_user/network_handler/network_handler.dart';
import 'package:clean_pro_user/repository/auth_local_repo.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddressRepo {
  addAddress(String street, String city, String state, String postalCode,
      List<double> coordinates) async {
    try {
      String? userId = await AuthLocalRepo.getToken();
      var a = await NetworkHandler.post("addAddress", {
        "userId": userId,
        "street": street,
        "city": city,
        "state": city,
        "postalCode": city,
        "coordinates": city
      });
      if (a["sucess"]) {
        Get.showSnackbar(GetSnackBar(
          title: "Address Sucess fully Added",
        ));
      }
      else{
             Get.showSnackbar(GetSnackBar(
          title: "Address Adding failed",
        ));
      }
    } catch (e) {
      rethrow;
    }
  }
}
