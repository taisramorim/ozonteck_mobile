import 'package:cart_repository/src/entities/list_items_entity.dart';
import 'package:cart_repository/src/models/cart.dart';

class ListItems {
  final List<Cart> items;

  ListItems({
    required this.items,
  });

  double get totalPrice => items.fold(0, (total, current) => total + current.product.price * current.quantity);

  int get totalItems => items.fold(0, (total, current) => total + current.quantity);

  ListItemsEntity toEntity() {
    return ListItemsEntity(
      items: items.map((cart) => cart.toEntity()).toList(),
    );
  }

  static ListItems fromEntity(ListItemsEntity entity) {
    return ListItems(
      items: entity.items.map((cartEntity) => Cart.fromEntity(cartEntity)).toList(),
    );
  }
}
