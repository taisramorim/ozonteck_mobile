import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_repository/product_repository.dart';

class FirebaseProductRepository implements ProductRepository {
  final productCollection = FirebaseFirestore.instance.collection('products');

  @override
  Future<List<Product>> getProducts() async {
    try {
      return await productCollection
        .get()
        .then((value) => value.docs.map((e) => 
          Product.fromEntity(ProductEntity.fromDocument(e.data()))
        ).toList());
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