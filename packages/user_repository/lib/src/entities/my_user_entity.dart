import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? picture;
  bool hasActiveCart;
  int cartId = 0;
  double cartTotal = 0;
  int cartQuantity = 0;
  Map<String, int> personalStock;  
  Map<String, DateTime> cart;

  MyUserEntity ({
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

  Map<String, Object?> toDocument(){
    return {
      'id': id,
      'email': email,
      'name': name,
      'picture': picture,
      'hasActiveCart': hasActiveCart,
      'cartId': cartId,
      'cartTotal': cartTotal,
      'cartQuantity': cartQuantity,
      'personalStock': personalStock,
      'cart': cart
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
      email: doc['email'] as String,
      name: doc['name'] as String,
      picture: doc['picture'] as String?,
      hasActiveCart: doc['hasActiveCart'] as bool,
      cartId: doc['cartId'] as int,
      cartTotal: doc['cartTotal'] as double,
      cartQuantity: doc['cartQuantity'] as int,
      personalStock: Map<String, int>.from(doc['personalStock'] as Map),
      cart: Map<String, DateTime>.from(doc['cart'] as Map)
    );
  }
  

  @override
  List<Object?> get props => [id, email, name, picture, hasActiveCart, cartId, cartTotal, cartQuantity, personalStock, cart];

  @override
  String toString(){
    return '''UserEntity: {
      id: $id
      email: $email
      name: $name
      picture: $picture
      hasActiveCart: $hasActiveCart
      cartId: $cartId
      cartTotal: $cartTotal
      cartQuantity: $cartQuantity
      personalStock: $personalStock
      cart: $cart
    }''';
  }
}