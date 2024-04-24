part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginErrorState extends AuthState {
  final String message;

  const LoginErrorState({required this.message});
}

class LoginSuccessState extends AuthState {}


class LogoutLoadingState extends AuthState {}

class LogoutErrorState extends AuthState {
  final String message;

  const LogoutErrorState({required this.message});
}

class LogoutSuccessState extends AuthState {}
