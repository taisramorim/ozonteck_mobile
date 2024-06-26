part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartUpdated extends CartState {
  final Cart cart;

  const CartUpdated({required this.cart});

  @override
  List<Object> get props => [cart];
}

class CartError extends CartState {}
