class ProductModel {
  final int id;
  final int categoryId;
  final String categoryName;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final int stockQuantity;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.stockQuantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      categoryId: json['category_id'] is int
          ? json['category_id']
          : int.parse(json['category_id'].toString()),
      categoryName: json['category_name'] ?? '',
      name: json['name'] ?? '',
      price: double.parse(
        json['price'].toString(),
      ), // Always ensure decimals are parsed correctly
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      stockQuantity: json['stock_quantity'] is int
          ? json['stock_quantity']
          : int.parse(json['stock_quantity'].toString()),
    );
  }
}
