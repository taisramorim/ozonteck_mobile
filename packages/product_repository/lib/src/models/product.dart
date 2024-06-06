import 'package:product_repository/product_repository.dart';

class Product{
  String productId;
  String picture;
  String name;
  String description;
  int price;
  int discount;
  int stock;
  int rating;
  String category;

  Product({
    required this.productId,
    required this.picture,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.stock,
    required this.rating,
    required this.category,
  });

  ProductEntity toEntity() {
    return ProductEntity(
      productId: productId,
      picture: picture,
      name: name,
      description: description,
      price: price,
      discount: discount,
      stock: stock,
      rating: rating,
      category: category,
    );
  }

  static Product fromEntity(ProductEntity entity) {
    return Product(
      productId: entity.productId,
      picture: entity.picture,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      discount: entity.discount,
      stock: entity.stock,
      rating: entity.rating,
      category: entity.category,
    );
  }
}