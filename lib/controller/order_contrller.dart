import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderController extends GetxController {
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> confirmOrder({
    required String userId,
    required String addressId,
    required String deliveryMode,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await http.post(
        Uri.parse('https://clean-pro-2.onrender.com/api/user/order'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          //66e7bf4a885a137a976a2578
          'addressId': addressId,
          //66e903704f26430d99a49870
          'deliveryMode': deliveryMode,
          // express
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          // Order confirmed successfully
          Get.snackbar('Success', 'Order confirmed successfully');
          // You can add additional logic here, such as navigating to a success page
          // or updating the UI to reflect the new order
        } else {
          error.value = data['message'] ?? 'Failed to create order';
        }
      } else if (response.statusCode == 400) {
        final data = jsonDecode(response.body);
        error.value = data['message'] ?? 'Bad request';
      } else {
        error.value = 'Failed to confirm order. Please try again.';
      }
    } catch (e) {
      error.value =
          'An error occurred. Please check your connection and try again.';
      print('Error in confirmOrder: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
