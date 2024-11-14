part of 'checkout_cubit.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

final class CheckoutInitial extends CheckoutState {}
final class LoadingGetDeliveryAddressState   extends CheckoutState {}
final class GetDeliveryAddressState extends CheckoutState {}
final class FailedGetDeliveryAddressState extends CheckoutState {}
final class SelectedDeliveryAddressState extends CheckoutState {}
final class ToggleSummaryState extends CheckoutState {}
final class ToggleDeliveryAddressState extends CheckoutState {}
final class LoadingCreateOrderState extends CheckoutState {}
final class CreateOrderState extends CheckoutState {}
final class FailedCreateOrderState extends CheckoutState {}
final class GetDeliveryFeesState extends CheckoutState {}
