part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}
final class LoadingGetCartState extends CartState {}
final class GetCartSuccessfullyState extends CartState {}
final class FailedGetCartState extends CartState {}
final class StartDeleteCartItemState extends CartState {}
final class DeleteCartItemState extends CartState {}
final class DecrementQuantityState extends CartState {}
final class IncrementQuantityState extends CartState {}
final class StartDecrementQuantityState extends CartState {}
final class StartIncrementQuantityState extends CartState {}
final class GetTotalPriceState extends CartState {}
