import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  String? picture;
  final int points;
  final int level;

  MyUser({
    
    required this.id,
    required this.email,
    required this.name,
    this.picture,
    required this.points,
    required this.level,
  });

  // Empty user which represents an unauthenticated user
  static final empty = MyUser(
    id: '',
    email: '',
    name: '',
    picture: '',
    points: 0,
    level: 0,
  );
// Modify MyUser parameters
  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    String? picture,
    int? points,
    int? level,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      points: points ?? this.points,
      level: level ?? this.level,
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
      points: points,
      level: level,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      picture: entity.picture,
      points: entity.points,
      level: entity.level,
    );
  }

  @override
  List<Object?> get props => [id, email, name, picture, points, level];

  // @override
  // String toString(){
    // return 'MyUser: $id, $email, $name, $picture, $hasActiveCart'; }
}