part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;

  const AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final Product product;

  const RemoveFromCart(this.product);
}

class PurchaseCart extends CartEvent {
  const PurchaseCart();
}

class CartExpired extends CartEvent {
  final Product product;

  const CartExpired(this.product);
}
