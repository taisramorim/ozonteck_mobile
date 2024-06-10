import 'dart:developer';
import 'dart:io';

import 'package:cart_repository/cart_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCartRepository implements CartRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId;

  FirebaseCartRepository({required this.userId});

  @override
  Future<void> addItemToCart(Cart item) async {
    try {
      await _firestore.
      collection('users')
      .doc(userId)
      .collection('cart')
      .add(item.toEntity().toDocument());
    } catch (e) {
      log('Failed to add item to cart: ${e.toString()}');
      rethrow;      
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      final cartItems = await getCartItems();
      for (var item in cartItems) {
        await removeItemFromCart(item);
      }
    } catch (e) {
      log('Failed to clear cart: ${e.toString()}');
      rethrow;      
    }
  }

  @override
  Future<List<Cart>> getCartItems() async {
    try {
      final querySnapshot = await _firestore
      .collection('users')
      .doc(userId)
      .collection('cart')
      .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Cart.fromEntity(CartEntity.fromDocument(data));
      }).toList();
    } catch (e) {
      log('Failed to get cart items: ${e.toString()}');
      rethrow;      
    }
  }

  @override
  Future<void> removeItemFromCart(Cart item) async {
    try {
      await _firestore
      .collection('users')
      .doc(userId)
      .collection('cart')
      .doc(item.cartId)
      .delete();
    } catch (e) {
      log('Failed to remove item from cart: ${e.toString()}');
      rethrow;      
    }
  }
}