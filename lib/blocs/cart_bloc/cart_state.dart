part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState{}

final class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Cart> cartItems;

  const CartLoaded(this.cartItems);
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);
}
