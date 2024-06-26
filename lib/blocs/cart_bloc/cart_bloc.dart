import 'package:bloc/bloc.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:product_repository/product_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final FirebaseCartRepository _cartRepository;
  final String userId;
  
  CartBloc(this._cartRepository, this.userId) : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
    on<LoadCart>(_onLoadCart);
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cart = await _cartRepository.getCart(userId);
      emit(CartUpdated(cart: cart));
    } catch (e) {
      emit(CartError());
    }
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartUpdated) {
      final updatedCart = Cart(
        items: List.from(currentState.cart.items)
          ..add(CartItem(product: event.product, quantity: 1)),
      );
      await _cartRepository.updateCart(userId, updatedCart);
      emit(CartUpdated(cart: updatedCart));
    } else {
      final newCart = Cart(items: [CartItem(product: event.product, quantity: 1)]);
      await _cartRepository.updateCart(userId, newCart);
      emit(CartUpdated(cart: newCart));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartUpdated) {
      final updatedCart = Cart(
        items: currentState.cart.items.where((item) => item.product.productId != event.product.productId).toList(),
      );
      await _cartRepository.updateCart(userId, updatedCart);
      emit(CartUpdated(cart: updatedCart));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    final emptyCart = Cart(items: []);
    await _cartRepository.updateCart(userId, emptyCart);
    emit(CartUpdated(cart: emptyCart));
  }
}
