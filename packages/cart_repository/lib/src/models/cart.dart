import 'package:cart_repository/src/entities/cart_entity.dart';
import 'package:cart_repository/src/models/list_items.dart';
import 'package:product_repository/product_repository.dart';

class Cart {
  final String cartId;
  final Product product;
  final int quantity;
  final ListItems listItems;

  Cart({
    required this.cartId,
    required this.product,
    required this.quantity,
    required this.listItems,
  });

  CartEntity toEntity() {
    return CartEntity(
      cartId: cartId,
      product: product.toEntity(),
      quantity: quantity,
      listItems: listItems.toEntity(),
    );
  }

  static Cart fromEntity(CartEntity entity) {
    return Cart(
      cartId: entity.cartId,
      product: Product.fromEntity(entity.product),
      quantity: entity.quantity,
      listItems: ListItems.fromEntity(entity.listItems),
    );
  }
}
