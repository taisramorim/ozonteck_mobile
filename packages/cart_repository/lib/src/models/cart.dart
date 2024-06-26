import 'package:cart_repository/cart_repository.dart';

class Cart {
  final List<CartItem> items;

  Cart({required this.items});

  double get totalPrice {
    return items.fold(0, (total, item) {
      return total + item.product.price * item.quantity;
    });
  }

  int get totalPoints {
    return items.fold(0, (total, current) {
      return total + current.product.points * current.quantity;
    });
  }

  CartEntity toEntity() {
    return CartEntity(
      items: items.map((item) => item.toEntity()).toList(),
    );
  }

  static Cart fromEntity(CartEntity entity) {
    return Cart(
      items: entity.items.map((item) => CartItem.fromEntity(item)).toList(),
    );
  }
}
