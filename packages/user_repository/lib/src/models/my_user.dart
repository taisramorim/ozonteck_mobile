import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  String? picture;
  bool hasActiveCart;
  int cartId = 0;
  double cartTotal = 0;
  int cartQuantity = 0;
  Map<String, int> personalStock;
  Map<String, DateTime> cart;

  MyUser({
    
    required this.id,
    required this.email,
    required this.name,
    this.picture,
    required this.hasActiveCart,
    this.cartId = 0,
    this.cartTotal = 0,
    this.cartQuantity = 0,
    this.personalStock = const {},
    this.cart = const {}
  });

  // Empty user which represents an unauthenticated user
  static final empty = MyUser(
    id: '',
    email: '',
    name: '',
    picture: '',
    hasActiveCart: false,
    cartId: 0,
    cartTotal: 0,
    cartQuantity: 0,
    personalStock: const {},
    cart: const {}

  );
// Modify MyUser parameters
  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    String? picture,
    bool? hasActiveCart,
    int? cartId,
    double? cartTotal,
    int? cartQuantity,
    Map<String, int>? personalStock,
    Map<String, DateTime>? cart

  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      hasActiveCart: hasActiveCart ?? this.hasActiveCart,
      cartId: cartId ?? this.cartId,
      cartTotal: cartTotal ?? this.cartTotal,
      cartQuantity: cartQuantity ?? this.cartQuantity,
      personalStock: personalStock ?? this.personalStock,
      cart: cart ?? this.cart
    );
  }

// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MyUser.empty;

// Convenience getter to determine whether the current user is not empty.
  bool get inNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity(){
    return MyUserEntity(
      id: id,
      email: email,
      name: name,
      picture: picture,
      hasActiveCart: hasActiveCart,
      cartId: cartId,
      cartTotal: cartTotal,
      cartQuantity: cartQuantity,
      personalStock: personalStock,
      cart: cart
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      picture: entity.picture,
      hasActiveCart: entity.hasActiveCart,
      cartId: entity.cartId,
      cartTotal: entity.cartTotal,
      cartQuantity: entity.cartQuantity,
      personalStock: entity.personalStock,
      cart: entity.cart
    );
  }

  @override
  List<Object?> get props => [id, email, name, picture, hasActiveCart, cartId, cartTotal, cartQuantity, personalStock, cart];

    @override
  String toString() {
    return 'MyUser(id: $id, email: $email, name: $name, picture: $picture, hasActiveCart: $hasActiveCart, cartId: $cartId, cartTotal: $cartTotal, cartQuantity: $cartQuantity, personalStock: $personalStock, cart: $cart)';
  }
}