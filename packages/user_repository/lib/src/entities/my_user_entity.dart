import 'package:cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  
  final String id;
  final String email;
  final String username;
  final String name;
  String? picture;
  int points;
  int level;
  int earnings;
  final List<String> recruitedUsers;
  final List<CartItemEntity> cart;

  MyUserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    this.picture,
    this.points = 0,
    this.level = 0,
    this.earnings = 0,
    this.recruitedUsers = const [],
    this.cart = const [],
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'name': name,
      'picture': picture ?? '',
      'points': points,
      'level': level,
      'earnings': earnings,
      'recruitedUsers': recruitedUsers,
      'cart': cart.map((item) => item.toDocument()).toList(),
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
      email: doc['email'] as String,
      username: doc['username'] as String,
      name: doc['name'] as String,
      picture: doc['picture'] as String?,
      points: doc['points'] as int,
      level: doc['level'] as int,
      earnings: doc['earnings'] as int,
      recruitedUsers: List<String>.from(doc['recruitedUsers'] as List),
      cart: (doc['cart'] as List).map((item) => CartItemEntity.fromDocument(item as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => [id, email, username, name, picture, points, level, earnings, recruitedUsers, cart];
}
