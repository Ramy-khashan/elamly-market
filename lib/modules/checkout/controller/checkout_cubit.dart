import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket/core/components/toast_app.dart';
import 'package:elamlymarket/modules/checkout/model/summary_product_model.dart';
import 'package:elamlymarket/modules/navigator_bar/view/navigator_bar_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/utils/storage_key.dart';
import '../../../market.dart';
import '../../add_edit_address/model/delivery_address_model.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  static CheckoutCubit get(context) => BlocProvider.of(context);
  List<DeliveryAddressModel> deliveryAddress = [];
  double deliveryAddressFees = 0;
  int? selectedDeliveryAddress;
  bool isToggledSummary = false;
  bool isToggledDeliveryAddress = false;
  bool isLoading = false;
  bool isLoadingCreateOrder = false;
  getDeliveryAddress() async {
    isLoading = true;
    emit(LoadingGetDeliveryAddressState());
    String? userDocID =
        await FlutterSecureStorage().read(key: StorageKey.userDocId);

    await FirebaseFirestore.instance
        .collection("delivery_address")
        .doc(userDocID)
        .collection("user_delivery_address")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        deliveryAddress.add(DeliveryAddressModel.fromJson(element.data()));
      });
      isLoading = false;

      emit(GetDeliveryAddressState());
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      isLoading = false;
      emit(FailedGetDeliveryAddressState());
    });
  }

  onSelectDeliveryAddress(int? val) {
    emit(CheckoutInitial());

    selectedDeliveryAddress = val;
    emit(SelectedDeliveryAddressState());
  }

  toggleSummary() {
    emit(CheckoutInitial());
    isToggledSummary = !isToggledSummary;
    emit(ToggleSummaryState());
  }

  toggleDeliveryAddress() {
    emit(CheckoutInitial());
    isToggledDeliveryAddress = !isToggledDeliveryAddress;
    emit(ToggleDeliveryAddressState());
  }

  getTotalPrice(List<SummaryProductModel> product) {
    double totalPrice = 0;
    product.forEach((element) {
      totalPrice += double.parse(element.price.toString());
    });
    totalPrice += deliveryAddressFees;
    return totalPrice;
  }

  createOrder({required List<SummaryProductModel> product}) async {
    isLoadingCreateOrder = true;
    emit(LoadingCreateOrderState());
    String? userDocID =
        await FlutterSecureStorage().read(key: StorageKey.userDocId);
    String? userName = await FlutterSecureStorage().read(key: StorageKey.name);
    String? token = await FlutterSecureStorage().read(key: StorageKey.token);

    await FirebaseFirestore.instance.collection("orders").add({
      "user_id": userDocID,
      "delivery_address_id": deliveryAddress[selectedDeliveryAddress!].id,
      "products": product
          .map((product) => {
                "product_id": product.productId,
                "product_title": product.title,
                "price":
                    (double.parse(product.price) / int.parse(product.quantity))
                        .toString(),
                "quantity": product.quantity,
                "is_on_sale": product.isOnSale,
                "price_before": product.priceBefore,
              })
          .toList(),
      "total_price": getTotalPrice(product).toString(),
      "is_paid": false,
      "delivery_id": "",
      "from": "Elamly market",
      "cancelReason": "",
      "code": generateRandomInt(),
      "delivery_fees": deliveryAddressFees.toString(),
      "is_cancelled": false,
      "created_at": DateTime.now().toUtc().toString(),
      "notification_token": token.toString()
    }).then((value) async {
      isLoadingCreateOrder = false;
      ScrollEndNotification(orderId: value.id, userName: userName);

      toastApp(message: "Order created successfully");
      emit(CreateOrderState());
      await FirebaseFirestore.instance
          .collection("cart")
          .doc(userDocID)
          .collection("cart_products")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection("cart")
              .doc(userDocID)
              .collection("cart_products")
              .doc(element.id)
              .delete();
        });
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      Navigator.pushAndRemoveUntil(
          Market.navigatorKet.currentContext!,
          MaterialPageRoute(builder: (context) => NavigatorBarScreen()),
          (route) => false);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      isLoadingCreateOrder = false;
      toastApp(message: "Order created failed");

      emit(FailedCreateOrderState());
    });
  }

  getDeliveryFees() {
    FirebaseFirestore.instance
        .collection("settings")
        .doc("delivery_fees")
        .get()
        .then((value) {
      deliveryAddressFees =
          double.parse(value.data()!["delivery_fees"].toString());
      emit(GetDeliveryFeesState());
    });
  }

  ScrollEndNotification({String? orderId, String? userName}) {
    FirebaseFirestore.instance
        .collection("admin")
        .where("role", isEqualTo: "admin")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        //   sendMultiNotificaction(
        //       token: element.data()["token"],
        //       title: "New Order",
        //       body: "$userName order new order with Order ID $orderId");
      });
    });
  }

  generateRandomInt() {
    Random random = Random();
    int randomString =
        int.parse((List.generate(4, (_) => random.nextInt(9))).join());
    return randomString.toString();
  }
}
