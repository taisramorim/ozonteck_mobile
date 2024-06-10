import 'dart:math';

import 'package:cart_repository/src/entities/cart_entity.dart';
import 'package:product_repository/product_repository.dart';

class Cart {
  final int cartId;
  final Product product;
  final int quantity;

  Cart({
    required this.cartId,
    required this.product,
    required this.quantity,
  });

  factory Cart.newCart(Product product, int quantity) {
    final random = Random();
    final cartId = random.nextInt(10000000);
    return Cart(
      cartId: cartId,
      product: product,
      quantity: quantity
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      cartId: cartId,
      product: product.toEntity(),
      quantity: quantity,
    );
  }

  static Cart fromEntity(CartEntity entity) {
    return Cart(
      cartId: entity.cartId,
      product: Product.fromEntity(entity.product),
      quantity: entity.quantity,
    );
  }
}
