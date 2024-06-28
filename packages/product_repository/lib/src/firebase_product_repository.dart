import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_repository/product_repository.dart';

class FirebaseProductRepository implements ProductRepository {
  final productCollection = FirebaseFirestore.instance.collection('products');

  @override
  Future<List<Product>> getProducts() async {
    try {
      log('Fetching products from Firestore...');
      QuerySnapshot snapshot = await productCollection.get();
      log('Fetched ${snapshot.docs.length} documents.');
      List<Product> products = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        log('Document data: $data'); // Log the document data

        return Product.fromEntity(ProductEntity.fromDocument(data));
      }).toList();
      log('Converted documents to Product objects.');
      return products;
    } catch (e) {
      log('Error fetching products: $e');
      throw Exception('Error fetching products from Firestore');
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