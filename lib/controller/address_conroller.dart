import 'package:clean_pro_user/network_handler/network_handler.dart';
import 'package:clean_pro_user/repository/auth_local_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  Future<void> addAddress(
      String street, String city, String state, String postalCode,
      {List<double>? coordinates}) async {
    try {
      if (coordinates == null) {
        // Get list of Placemark for the address
        List<Location> locations =
            await locationFromAddress("$street, $city, $state, $postalCode");

        if (locations.isNotEmpty) {
          // Room No.III/9, 3rd Floor, SDF Building, Kinfra Techno Industrialpark Calicut University PO, Kakkanchery, Kerala 673635
          // Extract latitude and longitude from the first placemark
          double latitude = locations.first.latitude;
          double longitude = locations.first.longitude;
          coordinates = [latitude, longitude];

          print('Latitude: $latitude, Longitude: $longitude');
        }
      }
      String? userId = await AuthLocalRepo.getToken();
      var response = await NetworkHandler.post("addAddress", {
        "userId": userId,
        "street": street,
        "city": city,
        "state": state,
        "postalCode": postalCode,
        "coordinates": coordinates
      });

      if (response["success"]) {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Address Successfully Added",
            message: "Your address has been added to your profile.",
            duration: Duration(seconds: 3),
          ),
        );
        Get.back();
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Address Editing Failed",
            message:
                "There was an error Editing your address. Please try again.",
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: "An unexpected error occurred: ${e.toString()}",
          duration: const Duration(seconds: 3),
        ),
      );
      rethrow;
    }
  }

  Future<void> editAddress(String street, String city, String state,
      String postalCode, List<double> coordinates, String addresId) async {
    try {
      String? userId = await AuthLocalRepo.getToken();
      var response = await NetworkHandler.post("editAddress", {
        "addressId": addresId,
        "userId": userId,
        "street": street,
        "city": city,
        "state": state,
        "postalCode": postalCode,
        "coordinates": coordinates
      });

      if (response["success"]) {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Address Successfully edited",
            message: "Your address has been added to your profile.",
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Address Editing Failed",
            message:
                "There was an error Editing your address. Please try again.",
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: "An unexpected error occurred: ${e.toString()}",
          duration: const Duration(seconds: 3),
        ),
      );
      rethrow;
    }
  }

  Future<void> deleteAddress(String street, String city, String state,
      String postalCode, List<double> coordinates, String addresId) async {
    try {
      String? userId = await AuthLocalRepo.getToken();
      var response = await NetworkHandler.delete("deleteAddress");

      if (response["success"]) {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Address Successfully Deleted",
            message: "Your address has been Deleted From your Account .",
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Address Deleting Failed",
            message:
                "There was an error Deleting  your address. Please try again.",
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: "An unexpected error occurred: ${e.toString()}",
          duration: const Duration(seconds: 3),
        ),
      );
      rethrow;
    }
  }
}
