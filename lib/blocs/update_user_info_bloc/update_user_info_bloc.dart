import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'update_user_info_event.dart';
part 'update_user_info_state.dart';

class UpdateUserInfoBloc extends Bloc<UpdateUserInfoEvent, UpdateUserInfoState> {
  final UserRepository userRepository;

  UpdateUserInfoBloc({required this.userRepository}) : super(UpdateUserInfoInitial());

  @override
  Stream<UpdateUserInfoState> mapEventToState(UpdateUserInfoEvent event) async* {
    if (event is UploadPicture) {
      yield* _mapUploadPictureToState(event);
    } else if (event is UpdateUserInfo) {
      yield* _mapUpdateUserInfoToState(event);
    } else if (event is ResetPassword) {
      yield* _mapResetPasswordToState(event);
    }
  }

  Stream<UpdateUserInfoState> _mapUploadPictureToState(UploadPicture event) async* {
    yield UploadPictureLoading();
    try {
      final userImage = await userRepository.uploadPicture(event.file, event.userId);
      yield UploadPictureSuccess(userImage);
    } catch (e) {
      yield UploadPictureFailure(e.toString());
    }
  }

  Stream<UpdateUserInfoState> _mapUpdateUserInfoToState(UpdateUserInfo event) async* {
    yield UpdateUserInfoLoading();
    try {
      await userRepository.updateUserInfo(event.userId, name: event.name, email: event.email);
      yield UpdateUserInfoSuccess();
    } catch (e) {
      yield UpdateUserInfoFailure(e.toString());
    }
  }

  Stream<UpdateUserInfoState> _mapResetPasswordToState(ResetPassword event) async* {
    yield ResetPasswordLoading();
    try {
      await userRepository.resetPassword(event.email);
      yield ResetPasswordSuccess();
    } catch (e) {
      yield ResetPasswordFailure(e.toString());
    }
  }
}
