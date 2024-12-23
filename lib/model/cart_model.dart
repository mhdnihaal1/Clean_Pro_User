class CartItemModel {
  final String id;
  final ClothItem clothItem;
   int quantity;
  final String service;

  CartItemModel({
    required this.id,
    required this.clothItem,
    required this.quantity,
    required this.service,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['_id'],
      clothItem: ClothItem.fromJson(json['clothItemId']),
      quantity: json['quantity'],
      service: json['service'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'clothItemId': clothItem.toJson(),
      'quantity': quantity,
      'service': service,
    };
  }

  @override
  String toString() {
    return 'CartItem(id: $id, clothItem: $clothItem, quantity: $quantity, service: $service)';
  }
}

class ClothItem {
  final String id;
  final String name;
  final String category;
  final List<int> icon;
  final Map<String, double> prices;

  ClothItem({
    required this.id,
    required this.name,
    required this.category,
    required this.icon,
    required this.prices,
  });

  factory ClothItem.fromJson(Map<String, dynamic> json) {
  var a=  Map<String, int>.from(json['prices']);
  Map<String, double>prices=a.map((key, value) => MapEntry(key, value.toDouble()));
    return ClothItem(
      id: json['_id'],
      name: json['name'],
      category: json['category'],
      icon: List<int>.from(json['icon']),
      prices:prices,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'category': category,
      'icon': icon,
      'prices': prices,
    };
  }

  @override
  String toString() {
    return 'ClothItem(id: $id, name: $name, category: $category, icon: $icon, prices: $prices)';
  }
}

class Cart {
  final String id;
  final String userId;
  final List<CartItemModel> items;

  Cart({
    required this.id,
    required this.userId,
    required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['_id'],
      userId: json['userId'],
      items: (json['items'] as List).map((item) => CartItemModel.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Cart(id: $id, userId: $userId, items: $items)';
  }

  List<Map<String, dynamic>> groupItemsByService() {
    Map<String, List<CartItemModel>> groupedItems = {};

    for (var item in items) {
      if (!groupedItems.containsKey(item.service)) {
        groupedItems[item.service] = [];
      }
      groupedItems[item.service]!.add(item);
    }

    return groupedItems.entries.map((entry) {
      return {
        'service': entry.key,
        'items': entry.value,
      };
    }).toList();
  }
}

class Address {
  final String id;
  final String userId;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Location location;

  Address({
    required this.id,
    required this.userId,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['_id'],
      userId: json['userId'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      isDefault: json['isDefault'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'isDefault': isDefault,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'location': location.toJson(),
    };
  }

  @override
  String toString() {
    return 'Address(id: $id, userId: $userId, street: $street, city: $city, state: $state, postalCode: $postalCode, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt, location: $location)';
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    var a=List<dynamic>.from(json['coordinates']);
  print(a.runtimeType);
  
    return Location(
      type: json['type'],
      coordinates:a.map((e) => double.parse(e.toString()),).toList() ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }

  @override
  String toString() {
    return 'Location(type: $type, coordinates: $coordinates)';
  }
}

class CartData {
  final Cart cart;
  final List<Address> addresses;

  CartData({
    required this.cart,
    required this.addresses,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      cart: Cart.fromJson(json['cart']),
      addresses: (json['addresses'] as List).map((address) => Address.fromJson(address)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart': cart.toJson(),
      'addresses': addresses.map((address) => address.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'CartData(cart: $cart, addresses: $addresses)';
  }
}

class CartResponse {
  final bool success;
  final CartData data;

  CartResponse({
    required this.success,
    required this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      success: json['success'],
      data: CartData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }

  @override
  String toString() {
    return 'CartResponse(success: $success, data: $data)';
  }
}