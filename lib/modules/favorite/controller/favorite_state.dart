part of 'favorite_cubit.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class LoadingGetFavoriteState extends FavoriteState {}

final class GetFavoriteSuccessfullyState extends FavoriteState {}

final class FailedGetFavoriteState extends FavoriteState {}

final class StartDeleteFavoriteItemState extends FavoriteState {}

final class DeleteFavoritetemState extends FavoriteState {}
