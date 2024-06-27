part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final MyUser user;
  final String password;
  final String recruiterId;

  const SignUpRequired(this.user, this.password, this.recruiterId);

  @override
  List<Object> get props => [user, password, recruiterId];
}
