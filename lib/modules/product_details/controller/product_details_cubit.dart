import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket/modules/home/model/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(
      {required String? productId, required ProductModel? productModel})
      : super(ProductDetailsInitial()) {
    if (productId == null) {
      productDetails = productModel;
    } else {
      getProduct(productId:productId);
    }
  }
  static ProductDetailsCubit get(context) => BlocProvider.of(context);
  ProductModel? productDetails;
  bool visibleDescription = true;
  toggleDescription() {
    emit(ProductDetailsInitial());
    visibleDescription = !visibleDescription;
    emit(ToggleVisibilityState());
  }

  bool isLoading = false;
  getProduct({String? productId}) async {
    isLoading = true;

    emit(LoadingGetProductState());

    await FirebaseFirestore.instance
        .collection("products")
        .doc(productId)
        .get()
        .then((value) {
      productDetails = ProductModel.fromJson(value.data()!);
      isLoading = false;
      emit(GetProductSuccessfullyState());
    }).onError((error, stackTrace) {
      isLoading = false;
      emit(FailedGetProductState());
      debugPrint(error.toString());
    });
  }

  int quantity = 1;
  increment() {
    emit(StartChangeQuantityState());

    quantity++;
    emit(IncrementQuantityState());
  }

  decrement() {
    emit(StartChangeQuantityState());
    if (quantity > 1) {
      quantity--;
    }
    emit(DecrementQuantityState());
  }
}
