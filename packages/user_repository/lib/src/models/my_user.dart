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
  List<Cart> cart;


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

  // Empty user which represents an unauthenticated user
  static final empty = MyUser(
    id: '',
    email: '',
    username: '',
    name: '',
    picture: '',
    points: 0,
    level: 0,
    earnings: 0,
    recruitedUsers: const [],
    cart: const [],
  );

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
    List<Cart>? cart,
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

// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MyUser.empty;

// Convenience getter to determine whether the current user is not empty.
  bool get inNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity(){
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
      cart: cart,
      
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
      cart: entity.cart,
    );
  }

  @override
  List<Object?> get props => [id, email, username, name, picture, points, level, earnings, recruitedUsers, cart];

  // @override
  // String toString(){
    // return 'MyUser: $id, $email, $name, $picture, $hasActiveCart'; }
}