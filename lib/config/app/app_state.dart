part of 'app_cubit.dart';

sealed class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

final class AppInitial extends AppState {}
final class GetSavedDataState extends AppState {}

final class ThemeControllerInitial extends AppState {}

final class StartFetchSavedThemeState extends AppState {}

final class GetSavedThemeState extends AppState {}

final class ChangeBrightnessState extends AppState {}

final class StartChangeBrightnessState extends AppState {}
