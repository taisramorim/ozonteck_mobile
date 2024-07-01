import 'package:cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class MyUser extends Equatable {
  
  final String id;
  final String email;
  final String username;
  final String name;
  String? picture;
  int points;
  int level;
  int earnings;
  final List<String> recruitedUsers;
  List<CartItem> cart;

  MyUser({
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

  // Modify MyUser parameters
  MyUser copyWith({
    String? id,
    String? email,
    String? username,
    String? name,
    String? picture,
    int? points,
    int? level,
    int? earnings,
    List<String>? recruitedUsers,
    List<CartItem>? cart,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      points: points ?? this.points,
      level: level ?? this.level,
      earnings: earnings ?? this.earnings,
      recruitedUsers: recruitedUsers ?? this.recruitedUsers,
      cart: cart ?? this.cart,
    );
  }

  MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      email: email,
      username: username,
      name: name,
      picture: picture,
      points: points,
      level: level,
      earnings: earnings,
      recruitedUsers: recruitedUsers,
      cart: cart.map((item) => item.toEntity()).toList(),
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      name: entity.name,
      picture: entity.picture,
      points: entity.points,
      level: entity.level,
      earnings: entity.earnings,
      recruitedUsers: entity.recruitedUsers,
      cart: entity.cart.map((item) => CartItem.fromEntity(item)).toList(),
    );
  }

  @override
  List<Object?> get props => [id, email, username, name, picture, points, level, earnings, recruitedUsers, cart];
}
