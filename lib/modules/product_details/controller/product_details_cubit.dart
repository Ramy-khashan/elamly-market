import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket/core/components/toast_app.dart';
import 'package:elamlymarket/modules/home/model/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/components/need_login_model_sheet.dart';
import '../../../core/utils/service_locator.dart';
import '../../../core/utils/storage_key.dart';
import '../../home/controller/home_cubit.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(
      {required String? productId, required ProductModel? productModel})
      : super(ProductDetailsInitial()) {
    if (productId == null) {
      productDetails = productModel;
    } else {
      getProduct(productId: productId);
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
   try{ isLoading = true;

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
      // debugPrint(error.toString());
    });}catch(e){
       isLoading = false;
      emit(FailedGetProductState());
    }
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

  bool isLoadingAddToBasket = false;
  addToBasket(context) async {
    try {
      isLoadingAddToBasket = true;
      emit(AddProductToBasketState());

      String? userID =
          await const FlutterSecureStorage().read(key: StorageKey.userDocId);
      if (userID == null) {
        needLogin(context: context);
      } else {
     await   sl.get<HomeCubit>().addToCart(productDetails!, quantity);
      }
      isLoadingAddToBasket = false;

      emit(AddedProductToBasketState());
    } catch (e) {
      isLoadingAddToBasket = false;
      toastApp(message: e.toString());
      emit(FailedAddProductToBasketState());
    }
  }
}
