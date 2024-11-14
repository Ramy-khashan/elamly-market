part of 'explore_cubit.dart';

sealed class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

final class ExploreInitial extends ExploreState {}
final class LoadingCategoriesState extends ExploreState {}
final class GetCategoriesState extends ExploreState {}
final class FailedGetCategoriesState extends ExploreState {}
