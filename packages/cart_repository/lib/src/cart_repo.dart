import 'package:cart_repository/cart_repository.dart';

abstract class CartRepo{
  
  Future<void> addItemToCart(Cart item);

  Future <void> removeItemFromCart(Cart item);

  Future<void> clearCart();

  Future<List<Cart>> getCartItems();
  
}