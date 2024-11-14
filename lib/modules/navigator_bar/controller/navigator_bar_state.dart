part of 'navigator_bar_cubit.dart';

sealed class NavigatorBarState extends Equatable {
  const NavigatorBarState();

  @override
  List<Object> get props => [];
}

final class NavigatorBarInitial extends NavigatorBarState {}
final class NavigatorBarTabSelectedState extends NavigatorBarState {}
final class GetUserDataState extends NavigatorBarState {}
