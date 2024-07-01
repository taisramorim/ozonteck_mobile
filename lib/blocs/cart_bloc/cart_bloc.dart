import 'package:bloc/bloc.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo _cartRepository;
  final ProductRepository _productRepository;
  final UserRepository _userRepository;

  CartBloc({
    required CartRepo cartRepository,
    required ProductRepository productRepository,
    required UserRepository userRepository,
  })  : _cartRepository = cartRepository,
        _productRepository = productRepository,
        _userRepository = userRepository,
        super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<PurchaseProducts>(_onPurchaseProducts);
    on<LoadCart>(_onLoadCart);
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      final cart = await _cartRepository.getCart(event.userId);
      cart.items.add(event.cartItem);
      await _cartRepository.updateCart(event.userId, cart);
      emit(CartUpdateSuccess());
      add(LoadCart(userId: event.userId));
    } catch (e) {
      emit(CartUpdateFailure(e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    try {
      final cart = await _cartRepository.getCart(event.userId);
      cart.items.remove(event.cartItem);
      await _cartRepository.updateCart(event.userId, cart);
      emit(CartUpdateSuccess());
      add(LoadCart(userId: event.userId));
    } catch (e) {
      emit(CartUpdateFailure(e.toString()));
    }
  }

  Future<void> _onPurchaseProducts(PurchaseProducts event, Emitter<CartState> emit) async {
    try {
      final cart = await _cartRepository.getCart(event.userId);
      int totalPoints = cart.items.fold(0, (sum, item) => sum + item.totalPoints);
      cart.items.clear();
      await _cartRepository.updateCart(event.userId, cart);
      await _userRepository.updateUserPoints(event.userId, totalPoints);
      emit(PurchaseSuccess());
      add(LoadCart(userId: event.userId));
    } catch (e) {
      emit(PurchaseFailure(e.toString()));
    }
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    try {
      final cart = await _cartRepository.getCart(event.userId);
      emit(CartLoaded(cart: cart.items));
    } catch (e) {
      emit(CartLoadFailure(e.toString()));
    }
  }
}
