import 'package:product_repository/product_repository.dart';

class Product {

  final String productId;
  final String name;
  final String description;
  final int price; 
  final int points;
  final String category;
  final String imageUrl;
  final int stock;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.points,
    required this.category,
    required this.imageUrl,
    required this.stock,
  });

  ProductEntity toEntity() {
    return ProductEntity(
      productId: productId,
      name: name,
      description: description,
      price: price,
      points: points,
      category: category,
      imageUrl: imageUrl,
     stock:stock,
    );
  }

  static Product fromEntity(ProductEntity entity) {
    return Product(
      productId: entity.productId,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      points: entity.points,
      category: entity.category,
      imageUrl: entity.imageUrl,
     stock: entity.stock,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] as String? ?? '',
      name: json['name'] as String? ?? 'Unnamed Product',
      description: json['description'] as String? ?? 'No description',
      price: (json['price'] as num?)?.toInt() ?? 0,
      points: (json['points'] as num?)?.toInt() ?? 0,
      category: json['category'] as String? ?? 'Uncategorized',
      imageUrl: json['imageUrl'] as String? ?? '',
     stock: (json['stock'] as num?)?.toInt() ?? 0,
    );
  }
}