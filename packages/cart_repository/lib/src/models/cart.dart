import 'package:cart_repository/cart_repository.dart';

class Cart {
  final List<CartItem> items;

  Cart({List<CartItem>? items}) : items = items ?? [];

  int get totalPrice => items.fold(0, (total, item) => total + item.totalPrice);
  int get totalPoints => items.fold(0, (total, item) => total + item.totalPoints);

  CartEntity toEntity() {
    return CartEntity(
      items: items.map((item) => item.toEntity()).toList(),
    );
  }

  static Cart fromEntity(CartEntity entity) {
    return Cart(
      items: List<CartItem>.from(entity.items.map((item) => CartItem.fromEntity(item))),
    );
  }
}
