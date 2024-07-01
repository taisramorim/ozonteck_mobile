import 'package:product_repository/product_repository.dart';

class CartItemEntity {
  final ProductEntity product;
  final int quantity;

  CartItemEntity({
    required this.product,
    required this.quantity,
  });

  Map<String, Object?> toDocument() {
    return {
      'product': product.toDocument(),
      'quantity': quantity,
    };
  }

  static CartItemEntity fromDocument(Map<String, dynamic> doc) {
    return CartItemEntity(
      product: ProductEntity.fromDocument(doc['product'] as Map<String, dynamic>),
      quantity: doc['quantity'] as int,
    );
  }
}
