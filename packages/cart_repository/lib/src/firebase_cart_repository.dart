import 'dart:developer';

import 'package:cart_repository/cart_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCartRepository implements CartRepo {

  final cartCollection = FirebaseFirestore.instance.collection('carts');

  @override
  Future<Cart> getCart(String userId) async {
    try {
      final doc = await cartCollection.doc(userId).get();
      return Cart.fromEntity(doc.data() as CartEntity);
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