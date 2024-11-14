part of 'orders_cubit.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}
final class LoadingOrdersState extends OrdersState {}
final class GetOrdersState extends OrdersState {}
final class FailedGetOrdersState extends OrdersState {}
