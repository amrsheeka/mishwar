part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

//login
final class LoginLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {}

final class LoginErrorState extends AuthState {
  final String message;
  LoginErrorState(this.message);
}

//signup
final class SignupLoadingState extends AuthState {}

final class SignupSuccessState extends AuthState {}

final class SignupErrorState extends AuthState {
  final String message;
  SignupErrorState(this.message);
}

//email Confirmation
final class EmailConfirmationLoadingState extends AuthState {}

final class EmailConfirmationSuccessState extends AuthState {}

final class EmailConfirmationErrorState extends AuthState {
  final String message;
  EmailConfirmationErrorState(this.message);
}
