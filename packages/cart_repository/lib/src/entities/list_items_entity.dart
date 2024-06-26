import 'package:cart_repository/cart_repository.dart';

class ListItemsEntity {
  final List<CartEntity> items;

  ListItemsEntity({
    required this.items,
  });

  Map<String, dynamic> toDocument() {
    return {
      'items': items.map((cart) => cart.toDocument()).toList(),
    };
  }

  static ListItemsEntity fromDocument(Map<String, dynamic> doc) {
    return ListItemsEntity(
      items: List<CartEntity>.from(doc['items'].map((item) => CartEntity.fromDocument(item))),
    );
  }
}
