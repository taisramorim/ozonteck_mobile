import 'package:product_repository/src/models/product.dart';

abstract class ProductRepository{
  Future<List<Product>> getProducts();
}