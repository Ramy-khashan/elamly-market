part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}
final class StartViewPasswordState extends LoginState {}
final class ChangeViewPasswordState extends LoginState {}
final class LoadingLoginState extends LoginState {}
final class LoginSuccessState extends LoginState {}
final class LoginFailedState extends LoginState {}
