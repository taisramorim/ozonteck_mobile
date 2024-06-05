import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  String? picture;
  bool hasActiveCart;

  MyUser({
    
    required this.id,
    required this.email,
    required this.name,
    this.picture,
    required this.hasActiveCart

  });

  // Empty user which represents an unauthenticated user
  static final empty = MyUser(
    id: '',
    email: '',
    name: '',
    picture: '',
    hasActiveCart: false

  );
// Modify MyUser parameters
  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    String? picture,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      hasActiveCart: hasActiveCart
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
      hasActiveCart: hasActiveCart
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      picture: entity.picture,
      hasActiveCart: entity.hasActiveCart
    );
  }

  @override
  List<Object?> get props => [id, email, name, picture];

  // @override
  // String toString(){
    // return 'MyUser: $id, $email, $name, $picture, $hasActiveCart'; }
}