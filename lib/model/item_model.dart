// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
  final String id;
  final List<Item> items;
  final int totalItems;

  Category({
    required this.id,
    required this.items,
    required this.totalItems,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      items:
          (json['items'] as List).map((item) => Item.fromJson(item)).toList(),
      totalItems: json['totalItems'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'totalItems': totalItems,
    };
  }

  static List<Category> convertJsonToCategories(
      Map<String, dynamic> jsonResponse) {
    if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
      List<dynamic> categoryData = jsonResponse['data'];
      return categoryData
          .map((category) => Category.fromJson(category))
          .toList();
    }
    return [];
  }

  @override
  String toString() {
    return 'Category(id: $id, items: $items, totalItems: $totalItems)';
  }
}

class Item {
  final String id;
  final String name;
  final String category;
  final List<int> icon;
  final Prices prices;
  final DateTime createdAt;
  final DateTime updatedAt;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.icon,
    required this.prices,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'],
      name: json['name'],
      category: json['category'],
      icon: List<int>.from(json['icon']),
      prices: Prices.fromJson(json['prices']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'category': category,
      'icon': icon,
      'prices': prices.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Item(id: $id, name: $name, category: $category, icon: "List<int>uint8List", prices: $prices, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  double getPrice(String service) {
    if (service[0].toLowerCase() == "w") {
      return prices.wash;
    }
    if (service[0].toLowerCase() == "i") {
      return prices.iron;
    }
    if (service[0].toLowerCase() == "d") {
      return prices.dryClean;
    }
    return 0;
  }
}

class Prices {
  double dryClean;
  double wash;
  double iron;

  Prices({
    required this.dryClean,
    required this.wash,
    required this.iron,
  });

  factory Prices.fromJson(Map<String, dynamic> json) {
    return Prices(
      dryClean: double.parse(json['dryClean'].toString()),
      wash: double.parse(json['wash'].toString()),
      iron: double.parse(json['iron'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dryClean': dryClean,
      'wash': wash,
      'iron': iron,
    };
  }

  @override
  String toString() {
    return 'Prices(dryClean: $dryClean, wash: $wash, iron: $iron)';
  }
}

class ItemModelController {
  Item item;
  int count;


  ItemModelController({
    required this.item,
    this.count = 0,
  });

  @override
  String toString() {
    return 'ItemModelController(item: $item, count: $count)';
  }
}
