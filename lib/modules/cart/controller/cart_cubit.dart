import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket/core/utils/storage_key.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    getCart();
    getTotalPrice();
  }
  static CartCubit get(context) => BlocProvider.of(context);
  List<CartModel> cartItem = [];
  bool isLoadingCart = false;
  String? userDocID;
  getCart() async {
    isLoadingCart = true;
    cartItem = [];
    emit(LoadingGetCartState());

    try {
      userDocID = await FlutterSecureStorage().read(key: StorageKey.userDocId);
      await FirebaseFirestore.instance
          .collection("cart")
          .doc(userDocID)
          .collection("cart_products")
          .get()
          .then((value) {
        value.docs.forEach((doc) {
          cartItem.add(CartModel.fromJson(doc.data()));
        });
        isLoadingCart = false;

        emit(GetCartSuccessfullyState());
      }).onError((error, stackTrace) {
        isLoadingCart = false;

        emit(FailedGetCartState());
      });
    } catch (e) {
      isLoadingCart = false;

      emit(FailedGetCartState());
    }
  }

  deleteItem({required int index}) {
    emit(StartDeleteCartItemState());
    String cartItemId = cartItem[index].id ?? "";
    cartItem.removeAt(index);
    FirebaseFirestore.instance
        .collection("cart")
        .doc(userDocID)
        .collection("cart_products")
        .doc(cartItemId)
        .delete();
    if (index == 0) {
      getCart();
    }
    emit(DeleteCartItemState());
  }

  decrement(int index) {
    if (cartItem[index].quantity! > 1) {
      emit(StartDecrementQuantityState());

      cartItem[index].quantity = (cartItem[index].quantity! - 1);
      FirebaseFirestore.instance
          .collection("cart")
          .doc(userDocID)
          .collection("cart_products")
          .doc(cartItem[index].id)
          .update({"quantity": cartItem[index].quantity!});
      emit(DecrementQuantityState());
    }
  }

  increment(int index) {
    emit(StartIncrementQuantityState());
    getTotalForProduct(index);
    cartItem[index].quantity = (cartItem[index].quantity! + 1);
    FirebaseFirestore.instance
        .collection("cart")
        .doc(userDocID)
        .collection("cart_products")
        .doc(cartItem[index].id)
        .update({"quantity": cartItem[index].quantity!});
    emit(IncrementQuantityState());
  }

  getTotalForProduct(int index) {
    double price = cartItem[index].productIsOnSale!
        ? double.parse(cartItem[index].productSalePrice!)
        : double.parse(cartItem[index].productPrice!);

    // totalPrice = getTotalPrice();
    getTotalPrice();
    return (price * cartItem[index].quantity!).toString();
    // return "";
  }

  double totalPrice = 0;
  getTotalPrice() {
    totalPrice = 0;
    cartItem.forEach((item) {
      double price = item.productIsOnSale!
          ? double.parse(item.productSalePrice!)
          : double.parse(item.productPrice!);
      // totalPrice = getTotalPrice();

      totalPrice += price * item.quantity!;
    });
    emit(GetTotalPriceState());
  }
}
