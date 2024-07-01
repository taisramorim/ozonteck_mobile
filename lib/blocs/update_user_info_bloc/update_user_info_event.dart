part of 'update_user_info_bloc.dart';

abstract class UpdateUserInfoEvent extends Equatable {
  const UpdateUserInfoEvent();

  @override
  List<Object> get props => [];
}

class UploadPicture extends UpdateUserInfoEvent {
  final String file;
  final String userId;

  const UploadPicture(this.file, this.userId);

  @override
  List<Object> get props => [file, userId];
}

class UpdateUserInfo extends UpdateUserInfoEvent {
  final String userId;
  final String name;
  final String email;

  const UpdateUserInfo(this.userId, {required this.name, required this.email});

  @override
  List<Object> get props => [userId, name, email];
}

class ResetPassword extends UpdateUserInfoEvent {
  final String email;

  const ResetPassword(this.email);

  @override
  List<Object> get props => [email];
}
