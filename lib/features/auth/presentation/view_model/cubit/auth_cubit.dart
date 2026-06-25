import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/utils/cach_helper.dart';
import 'package:mishwar/features/auth/data/models/auth_response_model.dart';
import 'package:mishwar/features/auth/data/services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());

    try {
      final AuthResponseModel result = await AuthService.login(
        email: email,
        password: password,
      );

      await CacheHelper.saveData(key: 'token', value: result.token);

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(SignupLoadingState());

    final result = await AuthService.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    if (result != null) {
      if (result == 'Account created. Confirm your email') {
        emit(SignupSuccessState());
      } else {
        emit(SignupErrorState(result));
      }
    } else {
      emit(SignupErrorState('Unexpected error'));
    }
  }

  Future<void> confirmEmail({
    required String email,
    required String code,
  }) async {
    emit(EmailConfirmationLoadingState());

    try {
      final AuthResponseModel result = await AuthService.confirmEmail(
        email: email,
        code: code,
      );
      await CacheHelper.saveData(key: 'token', value: result.token);
      emit(EmailConfirmationSuccessState());
    } catch (error) {
      emit(EmailConfirmationErrorState(error.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await AuthService.logout();
      emit(LogoutSucessState());
    } catch (error) {
      emit(LogoutErrorState(error.toString()));
    }
  }
}
