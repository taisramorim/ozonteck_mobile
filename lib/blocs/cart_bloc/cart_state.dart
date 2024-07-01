part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartUpdateSuccess extends CartState {}

class CartUpdateFailure extends CartState {
  final String error;

  const CartUpdateFailure(this.error);

  @override
  List<Object> get props => [error];
}

class PurchaseSuccess extends CartState {}

class PurchaseFailure extends CartState {
  final String error;

  const PurchaseFailure(this.error);

  @override
  List<Object> get props => [error];
}

class CartLoaded extends CartState {
  final List<CartItem> cart;

  const CartLoaded({required this.cart});

  @override
  List<Object> get props => [cart];
}

class CartLoadFailure extends CartState {
  final String error;

  const CartLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}