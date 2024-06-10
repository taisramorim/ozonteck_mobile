part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent{}

class AddItemToCart extends CartEvent {
  final Cart item;

  const AddItemToCart(this.item);
}

class RemoveItemFromCart extends CartEvent {
  final Cart item;

  const RemoveItemFromCart(this.item);
}

class ClearCart extends CartEvent {}