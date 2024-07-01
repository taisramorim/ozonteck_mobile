part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final String userId;
  final CartItem cartItem;

  const AddToCart({required this.userId, required this.cartItem});

  @override
  List<Object> get props => [userId, cartItem];
}

class RemoveFromCart extends CartEvent {
  final String userId;
  final CartItem cartItem;

  const RemoveFromCart({required this.userId, required this.cartItem});

  @override
  List<Object> get props => [userId, cartItem];
}

class PurchaseProducts extends CartEvent {
  final String userId;

  const PurchaseProducts({required this.userId});

  @override
  List<Object> get props => [userId];
}

class LoadCart extends CartEvent {
  final String userId;

  const LoadCart({required this.userId});

  @override
  List<Object> get props => [userId];
}