import 'dart:convert';
import 'package:clean_pro_user/constants/urls.dart';
import 'package:clean_pro_user/model/cart_model.dart';
import 'package:clean_pro_user/repository/auth_local_repo.dart';
import 'package:http/http.dart' as http;

class CartRepository {
  final String baseUrl = AppUrls.baseUrl;

  Future<Map<String, dynamic>> addToCart({
    required String userId,
    required String service,
    required List<CartItem> items,
  }) async {
    final url = Uri.parse('$baseUrl/addToCart');
    List<Map<String, dynamic>> itemMap =
        items.map((item) => item.toJson()).toList();
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json
            .encode({'userId': userId, 'service': service, 'items': itemMap}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          return {
            'success': true,
            'message': responseData['message'],
            'data': responseData['data']
          };
        } else {
          return {'success': false, 'message': responseData['message']};
        }
      } else if (response.statusCode == 400) {
        final responseData = json.decode(response.body);
        return {'success': false, 'message': responseData['message']};
      } else {
        return {
          'success': false,
          'message': 'Failed to add items to cart. Please try again.'
        };
      }
    } catch (e) {
      print('Error adding to cart: $e');
      return {
        'success': false,
        'message':
            'An error occurred. Please check your connection and try again.'
      };
    }
  }
  Future<Map<String, dynamic>> changeCartQantity({
    required String userId,
    required String service,
    required String itemId, 
    required int count 
  }) async {
    final url = Uri.parse('$baseUrl/changeQuantity');
   
    try {
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json
            .encode({ "userId":userId, "itemId":itemId, "service":service, "count":count }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          return {
            'success': true,
            'message': responseData['message'],
            'data': responseData['data']
          };
        } else {
          return {'success': false, 'message': responseData['message']};
        }
      } else if (response.statusCode == 400) {
        final responseData = json.decode(response.body);
        return {'success': false, 'message': responseData['message']};
      } else {
        return {
          'success': false,
          'message': 'Failed to add items to cart. Please try again.'
        };
      }
    } catch (e) {
      print('Error adding to cart: $e');
      return {
        'success': false,
        'message':
            'An error occurred. Please check your connection and try again.'
      };
    }
  }

  Future<Map<String, dynamic>?> getCartItems() async {
    String? userId = await AuthLocalRepo.getToken();
    final url = Uri.parse('$baseUrl/checkoutPage/$userId');

    if (userId != null) {
      try {
        final response = await http.get(
          url,
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);

          if (responseData['success']) {
            var response = CartResponse.fromJson(responseData);
            return {
              'success': true,
              'message': responseData['message'],
              'data': responseData,
            };
          } else {
            return {'success': false, 'message': responseData['message']};
          }
        } else if (response.statusCode == 400) {
          final responseData = json.decode(response.body);
          return {'success': false, 'message': responseData['message']};
        } else {
          return {
            'success': false,
            'message': 'Failed to add items to cart. Please try again.'
          };
        }
      } catch (e) {
        print('Error adding to cart: $e');
        return {
          'success': false,
          'message':
              'An error occurred. Please check your connection and try again.'
        };
      }
    }
  }
}

class CartItem {
  final String itemId;
  final int quantity;

  CartItem({required this.itemId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'quantity': quantity,
    };
  }
}
