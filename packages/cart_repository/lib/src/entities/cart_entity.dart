import 'package:cart_repository/src/entities/list_items_entity.dart';
import 'package:product_repository/product_repository.dart';

class CartEntity {
  final String cartId;
  final ProductEntity product;
  final int quantity;
  final ListItemsEntity listItems;

  CartEntity({
    required this.cartId,
    required this.product,
    required this.quantity,
    required this.listItems,
  });

  Map<String, dynamic> toDocument() {
    return {
      'cartId': cartId,
      'product': product.toDocument(),
      'quantity': quantity,
      'listItems': listItems.toDocument(),
    };
  }

  static CartEntity fromDocument(Map<String, dynamic> doc) {
    return CartEntity(
      cartId: doc['cartId'],
      product: ProductEntity.fromDocument(doc['product']),
      quantity: doc['quantity'],
      listItems: ListItemsEntity.fromDocument(doc['listItems']),
    );
  }
}
