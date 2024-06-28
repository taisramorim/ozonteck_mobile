part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final MyUser user;
  final String password;
  final String recruiterUsername;

  const SignUpRequired(this.user, this.password, this.recruiterUsername);

  @override
  List<Object> get props => [user, password, recruiterUsername];
}
