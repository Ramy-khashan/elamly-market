part of 'product_details_cubit.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}
final class ToggleVisibilityState extends ProductDetailsState {}
final class LoadingGetProductState extends ProductDetailsState {}
final class GetProductSuccessfullyState extends ProductDetailsState {}
final class FailedGetProductState extends ProductDetailsState {}
final class StartChangeQuantityState extends ProductDetailsState {}
final class IncrementQuantityState extends ProductDetailsState {}
final class DecrementQuantityState extends ProductDetailsState {}
