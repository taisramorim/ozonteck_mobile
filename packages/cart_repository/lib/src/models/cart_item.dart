import 'package:cart_repository/src/entities/cart_item_entity.dart';
import 'package:product_repository/product_repository.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  int get totalPrice => product.price * quantity;
  int get totalPoints => product.points * quantity;

  CartItemEntity toEntity() {
    return CartItemEntity(
      product: product.toEntity(),
      quantity: quantity,
    );
  }

  static CartItem fromEntity(CartItemEntity entity) {
    return CartItem(
      product: Product.fromEntity(entity.product),
      quantity: entity.quantity,
    );
  }
}