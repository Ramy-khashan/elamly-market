part of 'forget_password_cubit.dart';

sealed class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgetPasswordInitial extends ForgetPasswordState {}
final class StartViewPasswordState extends ForgetPasswordState {}
final class ChangeViewPasswordState extends ForgetPasswordState {}
final class StartChangePasswordState extends ForgetPasswordState {}
final class ChangePasswordState extends ForgetPasswordState {}
