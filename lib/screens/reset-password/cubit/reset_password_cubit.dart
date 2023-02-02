import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/auth/auth_bloc.dart';
import '/models/failure.dart';
import '/repositories/auth/auth_repo.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;
  ResetPasswordCubit({
    required AuthBloc authBloc,
    required AuthRepository authRepository,
  })  : _authBloc = authBloc,
        _authRepository = authRepository,
        super(ResetPasswordState.initial());

  void load() {
    emit(state.copyWith(email: _authBloc.state.user?.email));
  }

  void emailChanged(String email) {
    emit(state.copyWith(email: email, status: ResetPasswordStatus.initial));
  }

  void resetPassword() async {
    try {
      emit(state.copyWith(status: ResetPasswordStatus.loading));
      await _authRepository.resetPassword(state.email);
      emit(state.copyWith(status: ResetPasswordStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: ResetPasswordStatus.error));
    }
  }
}
