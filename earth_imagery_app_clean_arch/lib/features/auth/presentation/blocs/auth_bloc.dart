import 'dart:async';
import 'dart:core';
import 'package:earth_imagery_app_clean_arch/features/auth/domain/entities/auth_entity.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:earth_imagery_app_clean_arch/features/auth/presentation/blocs/auth_event.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/presentation/blocs/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
    on<LoginEvent>(loginEvent);
    on<LogoutEvent>(logoutEvent);
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final authEntity =
          AuthEntity(username: event.username, password: event.password);

      final loginOrFailure = await authRepository.login(authEntity);
      if (loginOrFailure) {
        emit(AuthSuccessState(message: 'Login Successful'));
      } else {
        emit(AuthErrorState(message: 'Invalid username or password.'));
      }
    } catch (e) {
      emit(AuthErrorState(message: 'An Error Occured while Login'));
    }
  }

  FutureOr<void> logoutEvent(LogoutEvent event, Emitter<AuthState> emit) {}
}
