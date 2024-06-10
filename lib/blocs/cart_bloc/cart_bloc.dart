import 'package:bloc/bloc.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo cartRepo;

  CartBloc({required this.cartRepo}) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<ClearCart>(_onClearCart);
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cartItems = await cartRepo.getCartItems();
      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(const CartError('Failed to load cart'));
    }
  }

  void _onAddItemToCart(AddItemToCart event, Emitter<CartState> emit) async{
    if (state is CartLoaded) {
      final cartItems = List<Cart>.from((state as CartLoaded).cartItems);
      cartItems.add(event.item);
      emit(CartLoaded(cartItems));
      try {
        await cartRepo.addItemToCart(event.item);
      } catch (e) {
        emit(const CartError('Failed to add item to cart'));
      }
    }
  }

  void _onRemoveItemFromCart(RemoveItemFromCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final cartItems = List<Cart>.from((state as CartLoaded).cartItems)
      ..removeWhere((item) => item.product.productId == event.item.product.productId);
      emit(CartLoaded(cartItems));
      try {
        await cartRepo.removeItemFromCart(event.item);
      } catch (e) {
        emit(const CartError('Failed to remove item from cart'));
      }
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await cartRepo.clearCart();
      emit(const CartLoaded([]));
    } catch (e) {
      emit(const CartError('Failed to clear cart'));
    }
  }
}
