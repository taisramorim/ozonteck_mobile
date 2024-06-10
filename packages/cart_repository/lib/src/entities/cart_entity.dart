import 'package:product_repository/product_repository.dart';

class CartEntity {
  final int cartId;
  final ProductEntity product;
  final int quantity;

  CartEntity({
    required this.cartId,
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toDocument() {
    return {
      'cartId': cartId,
      'product': product.toDocument(),
      'quantity': quantity,
    };
  }

  static CartEntity fromDocument(Map<String, dynamic> doc) {
    return CartEntity(
      cartId: doc['cartId'],
      product: ProductEntity.fromDocument(doc['product']),
      quantity: doc['quantity'],
    );
  }
}
