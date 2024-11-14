part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class SlideBannerState extends HomeState {}

final class FailedGetAdsState extends HomeState {}

final class LoadingAdsState extends HomeState {}

final class GetAdsState extends HomeState {}

final class LoadingMostSellingState extends HomeState {}

final class GetMostSellingState extends HomeState {}

final class FailedGetMostSellingState extends HomeState {}

final class LoadingOffersState extends HomeState {}

final class GetOffersState extends HomeState {}

final class FailedGetOffersState extends HomeState {}
