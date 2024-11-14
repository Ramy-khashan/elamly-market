import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket/modules/home/model/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/enums.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState());
  List<ProductModel> productItems = [];
  Timer? _debounce;

  TextEditingController searchController = TextEditingController();
  getProduct() async {
    emit(state.copyWith(searchState: RequestState.loading));
    FirebaseFirestore.instance
        .collection("products")
        .limit(5000)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        productItems.add(ProductModel.fromJson(element.data()));
      });
      emit(state.copyWith(
          searchState: RequestState.loaded, products: productItems));
    }).onError((error, stackTrace) {
      debugPrint("Error : " + error.toString());
      emit(state.copyWith(searchState: RequestState.error, products: []));
    });
  }

  List<ProductModel> productsFromSearch = [];
  searcForProducts(String? val) {
    productsFromSearch =[]; //
 
 
      productItems.forEach((element) {
        print(val);
        print(element.title!.toLowerCase());
        print(element.title!
            .toLowerCase()
            .contains(searchController.text.toLowerCase()));
        if (element.title!.toLowerCase().contains(val!.toLowerCase()) ||
            element.description!.toLowerCase().contains(val.toLowerCase())) {
          productsFromSearch.add(element);
          print("productsFromSearch added: " + productsFromSearch.length.toString());
        }
      });
    
    productItems.length.toString();
    debugPrint("productItems : " + productItems.length.toString());
    debugPrint("productsFromSearch : " + productsFromSearch.length.toString());
    emit(state.copyWith(
        searchState: RequestState.loaded,
        products: val!.isEmpty ? productItems : productsFromSearch));
  }

  @override
  Future<void> close() async {
    super.close();
    _debounce?.cancel();
    searchController.clear();
  }
}
