part of 'regisiter_cubit.dart';

sealed class RegisiterState extends Equatable {
  const RegisiterState();

  @override
  List<Object> get props => [];
}

final class RegisiterInitial extends RegisiterState {}

final class StartViewPasswordState extends RegisiterState {}

final class ChangeViewPasswordState extends RegisiterState {}

final class StartSetPriceState extends RegisiterState {}

final class SetPriceState extends RegisiterState {}

final class LoadingCreateAccount extends RegisiterState {}

final class AccountCreatedState extends RegisiterState {}

final class AccountCreatedFailedState extends RegisiterState {}
