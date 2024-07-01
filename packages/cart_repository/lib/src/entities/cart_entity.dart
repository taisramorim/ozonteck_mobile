import 'package:cart_repository/cart_repository.dart';

class CartEntity {
  final List<CartItemEntity> items;

  CartEntity({this.items = const []});

  Map<String, Object?> toDocument() {
    return {
      'items': items.map((item) => item.toDocument()).toList(),
    };
  }

  static CartEntity fromDocument(Map<String, dynamic> doc) {
    return CartEntity(
      items: (doc['items'] as List).map((item) => CartItemEntity.fromDocument(item as Map<String, dynamic>)).toList(),
    );
  }
}