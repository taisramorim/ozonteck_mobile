import 'package:product_repository/src/models/product.dart';

abstract class ProductRepository{

  Future<List<Product>> getProducts();

  Future<void> updateProductStock(String productId, int stock);

  Future<int> fetchProductPoints(String productId);
}