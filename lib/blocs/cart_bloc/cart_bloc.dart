import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final MyUser userCart;
  final Map<String, Timer> cartTimers = {};

  CartBloc({required this.userCart}) : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<PurchaseCart>(_onPurchaseCart);
    on<CartExpired>(_onCartExpired);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final product = event.product;
    if (product.stock > 0) {
      final updateCart = Map<String, DateTime>.from(userCart.cart)
      ..putIfAbsent(product.productId, () => DateTime.now());

      final updatedUser = userCart.copyWith(cart: updateCart);

      // Remove one from stock
      product.stock -= 1;

      // Start a timer to expire the cart
      cartTimers[product.productId]?.cancel();
      cartTimers[product.productId] = Timer(const Duration(hours: 6), () {
        add(CartExpired(product));
      });

      emit(CartUpdated(updatedUser, userCart.cart.length));
    }else {
      emit(const CartError('Product is out of stock'));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final product = event.product;

    final updatedCart = Map<String, DateTime>.from(userCart.cart)..remove(product.productId);
    final updatedUser = userCart.copyWith(cart: updatedCart);

    // Add one to stock
    product.stock += 1;

    // Cancel the timer
    cartTimers[product.productId]?.cancel();
    cartTimers.remove(product.productId);

    emit(CartUpdated(updatedUser, userCart.cart.length));
  }

  void _onPurchaseCart(PurchaseCart event, Emitter<CartState> emit) {
    final updatedStock = Map<String, int>.from(userCart.personalStock);
    var updatedCartTotal = userCart.cartTotal;
    var updatedCartQuantity = userCart.cartQuantity;

    // Add the items in the cart to the stock
    for (final productId in userCart.cart.keys) {
      updatedStock.update(productId, (value) => value + 1, ifAbsent: () => 1);
      updatedCartTotal += 1; // Increase the total cart value
      updatedCartQuantity += 1; // Increase the total quantity of items in the cart
    }

    // Clear the cart
    final updatedUser = userCart.copyWith(
      personalStock: updatedStock,
      cart: {},
      cartTotal: updatedCartTotal,
      cartQuantity: updatedCartQuantity,
    );

    // Cancel all timers
    cartTimers.forEach((_, timer) => timer.cancel());
    cartTimers.clear();

    emit(CartPurchaseSuccess(updatedUser));
  }

  void _onCartExpired(CartExpired event, Emitter<CartState> emit){
    final product = event.product;
    final now = DateTime.now();

    if (userCart.cart.containsKey(product.productId)) {
      // Check if the product has been in the cart for more than 6 hours
      final addedTime = userCart.cart[product.productId]!;
      if (now.difference(addedTime).inHours >= 6) {
        // Remove the product from the cart
        final updatedCart = Map<String, DateTime>.from(userCart.cart)..remove(product.productId);

        // Add one to stock
        product.stock += 1;

        // Update the user
        final updatedUser = userCart.copyWith(cart: updatedCart);

        // Cancel the timer
        cartTimers[product.productId]?.cancel();
        cartTimers.remove(product.productId);

        emit(CartUpdated(updatedUser, userCart.cart.length));
      } 
    }
  }
}
