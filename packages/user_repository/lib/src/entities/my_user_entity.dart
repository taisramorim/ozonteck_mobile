import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? picture;
  final int points;
  final int level;
  
  MyUserEntity ({
    required this.id,
    required this.email,
    required this.name,
    this.picture,
    required this.points,
    required this.level,
  });

  Map<String, Object?> toDocument(){
    return {
      'id': id,
      'email': email,
      'name': name,
      'picture': picture,
      'points': points,
      'level': level,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
      email: doc['email'] as String,
      name: doc['name'] as String,
      picture: doc['picture'] as String?,
      points: doc['points'] as int,
      level: doc['level'] as int,
    );
  }
  

  @override
  List<Object?> get props => [id, email, name, picture, points, level];

  @override
  String toString(){
    return '''UserEntity: {
      id: $id
      email: $email
      name: $name
      picture: $picture
      points: $points
      level: $level
    }''';
  }
}