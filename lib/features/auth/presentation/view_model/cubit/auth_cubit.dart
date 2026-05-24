import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/features/auth/data/services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({AuthService? authService})
    : _authService = authService ?? AuthService(),
      super(AuthInitial());

  final AuthService _authService;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());

    try {
      await _authService.login(email: email, password: password);
      emit(LoginSuccessState());
    } on AuthException catch (error) {
      emit(LoginErrorState(error.message));
    } catch (error) {
      emit(LoginErrorState(error.toString()));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(SignupLoadingState());

    try {
      await _authService.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      emit(SignupSuccessState());
    } on AuthException catch (error) {
      emit(SignupErrorState(error.message));
    } catch (error) {
      emit(SignupErrorState(error.toString()));
    }
  }

  Future<void> confirmEmail({
    required String email,
    required String code,
  }) async {
    emit(EmailConfirmationLoadingState());

    try {
      await _authService.confirmEmail(email: email, code: code);
      emit(EmailConfirmationSuccessState());
    } on AuthException catch (error) {
      emit(EmailConfirmationErrorState(error.message));
    } catch (error) {
      emit(EmailConfirmationErrorState(error.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      emit(AuthInitial());
    } on AuthException catch (error) {
      emit(LoginErrorState(error.message));
    } catch (error) {
      emit(LoginErrorState(error.toString()));
    }
  }
}
