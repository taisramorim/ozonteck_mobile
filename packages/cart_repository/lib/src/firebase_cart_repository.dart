import 'dart:developer';

import 'package:cart_repository/cart_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCartRepository implements CartRepo {
  final cartCollection = FirebaseFirestore.instance.collection('carts');

  @override
  Future<Cart> getCart(String userId) async {
    try {
      final doc = await cartCollection.doc(userId).get();
      if (doc.exists) {
        return Cart.fromEntity(CartEntity.fromDocument(doc.data() as Map<String, dynamic>));
      } else {
        log('Cart document does not exist');
        return Cart(items: []); // Return an empty, modifiable cart
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateCart(String userId, Cart cart) async {
    try {
      return cartCollection.doc(userId).set(cart.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
