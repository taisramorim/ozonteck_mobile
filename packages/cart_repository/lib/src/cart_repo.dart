import 'package:cart_repository/cart_repository.dart';

abstract class CartRepo{

  Future<Cart> getCart(String userId);

  Future<void> updateCart(String userId, Cart cart);

}