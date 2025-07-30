class StockResponse {
  final bool success;
  final String note;
  final int totalProducts;
  final List<StockItem> data;
  final String message;

  StockResponse({
    required this.success,
    required this.note,
    required this.totalProducts,
    required this.data,
    required this.message,
  });

  factory StockResponse.fromJson(Map<String, dynamic> json) {
    return StockResponse(
      success: json['success'],
      note: json['note'],
      totalProducts: json['total_products'],
      data: (json['data'] as List).map((item) => StockItem.fromJson(item)).toList(),
      message: json['message'],
    );
  }
}

class StockItem {
  final Product product;
  final String category;
  final String strength;
  final String strengthLevel;
  final int availableQuantity;

  StockItem({
    required this.product,
    required this.category,
    required this.strength,
    required this.strengthLevel,
    required this.availableQuantity,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
      product: Product.fromJson(json['Product']),
      category: json['Category'],
      strength: json['Strength'],
      strengthLevel: json['StrengthLevel'],
      availableQuantity: json['AvailableQuantity'],
    );
  }
}

class Product {
  final String id;
  final String name;

  Product({
    required this.id,
    required this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['ID'],
      name: json['Name'],
    );
  }
} 