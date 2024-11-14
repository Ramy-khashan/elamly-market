import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/model/product.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  static CategoryCubit get(context) => BlocProvider.of(context);
  List<ProductModel> categoryProducts = [];
  bool isLoadingProduct = false;
  getCategoryProducts({required String categoryId}) {
    isLoadingProduct = true;
    categoryProducts = [];
    emit(LoadingProductState());
    FirebaseFirestore.instance
        .collection("products")
        .where("category_id", isEqualTo: categoryId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        categoryProducts.add(ProductModel.fromJson(element.data()));
      }
      isLoadingProduct = false;
      emit(GetProductState());
    }).onError((error, stackTrace) {
      isLoadingProduct = false;

      emit(FailedGetProductState());
    });
  }
}
