part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}


class CartUpdated extends CartState {
  final MyUser user;
  final int totalItems;
  
  const CartUpdated(this.user, this.totalItems);

}

class CartPurchaseSuccess extends CartState {
  final MyUser user;

  const CartPurchaseSuccess(this.user);
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);
}
