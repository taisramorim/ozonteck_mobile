import 'package:product_repository/product_repository.dart';

class CartItemEntity {
  final Product product;
  final int quantity;

  CartItemEntity({required this.product, required this.quantity});

  Map<String, dynamic> toDocument() {
    return {
      'product': product.toEntity().toDocument(),
      'quantity': quantity,
    };
  }

  static CartItemEntity fromDocument(Map<String, dynamic> doc) {
    return CartItemEntity(
      product: Product.fromEntity(ProductEntity.fromDocument(doc['product'])),
      quantity: doc['quantity'] as int,
    );
  }
}
