part of 'search_cubit.dart';

class SearchState extends Equatable {
  final List<ProductModel> products;
  final RequestState searchState;
  const SearchState(
      {this.products = const [], this.searchState = RequestState.init});
  @override
  List<Object> get props => [products, searchState];
  SearchState copyWith({
    List<ProductModel>? products,
    RequestState? searchState,
  }) {
    return SearchState(
      products: products ?? this.products,
      searchState: searchState ?? this.searchState,
    );
  }
}
