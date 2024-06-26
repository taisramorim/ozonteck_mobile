import 'package:cart_repository/src/entities/cart_item_entity.dart';
import 'package:product_repository/product_repository.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});
  
  CartItemEntity toEntity() {
    return CartItemEntity(
      product: product,
      quantity: quantity,
    );
  }

  static CartItem fromEntity(CartItemEntity entity) {
    return CartItem(
      product: entity.product,
      quantity: entity.quantity,
    );
  }
}
