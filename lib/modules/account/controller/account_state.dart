part of 'account_cubit.dart';

sealed class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

final class AccountInitial extends AccountState {}

final class GetUserDataState extends AccountState {}

final class GetDeleteAccountState extends AccountState {}

final class LoadingDeleteState extends AccountState {}

final class DeletedState extends AccountState {}

final class FailedDeleteState extends AccountState {}
