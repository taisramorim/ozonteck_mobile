import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_repository/product_repository.dart';

class FirebaseProductRepository implements ProductRepository {
  final productCollection = FirebaseFirestore.instance.collection('products');

  @override
  Future<List<Product>> getProducts() async {
    try {
      QuerySnapshot snapshot = await productCollection.get();
      List<Product> products = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Product.fromEntity(ProductEntity.fromDocument(data));
      }).toList();
      return products;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updatePersonalStock(String productId, int personalStock) async {
    try {
      await productCollection.doc(productId).update({
        'personalStock': personalStock,
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}