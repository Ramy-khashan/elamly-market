part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}
final class LoadingProductState extends CategoryState {}
final class GetProductState extends CategoryState {}
final class FailedGetProductState extends CategoryState {}
