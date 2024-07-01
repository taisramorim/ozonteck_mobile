part of 'update_user_info_bloc.dart';

abstract class UpdateUserInfoState extends Equatable {
  const UpdateUserInfoState();

  @override
  List<Object> get props => [];
}

class UpdateUserInfoInitial extends UpdateUserInfoState {}

class UploadPictureFailure extends UpdateUserInfoState {
  final String error;

  const UploadPictureFailure(this.error);

  @override
  List<Object> get props => [error];
}

class UploadPictureLoading extends UpdateUserInfoState {}

class UploadPictureSuccess extends UpdateUserInfoState {
  final String userImage;

  const UploadPictureSuccess(this.userImage);

  @override
  List<Object> get props => [userImage];
}

class UpdateUserInfoLoading extends UpdateUserInfoState {}

class UpdateUserInfoSuccess extends UpdateUserInfoState {}

class UpdateUserInfoFailure extends UpdateUserInfoState {
  final String error;

  const UpdateUserInfoFailure(this.error);

  @override
  List<Object> get props => [error];
}

class ResetPasswordLoading extends UpdateUserInfoState {}

class ResetPasswordSuccess extends UpdateUserInfoState {}

class ResetPasswordFailure extends UpdateUserInfoState {
  final String error;

  const ResetPasswordFailure(this.error);

  @override
  List<Object> get props => [error];
}
