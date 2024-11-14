import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket/core/components/toast_app.dart';
import 'package:elamlymarket/core/utils/storage_key.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/ads_model.dart';
import '../model/product.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  int currentIndex = 0;

  List<AdsModel> adsItems = [];

  List<ProductModel> offers = [];
  List<ProductModel> bestSellingProducts = [];

  List<ProductModel> groceriesProducts = [];

  bool isLoadingAds = false;

  Future<void> getAds() async {
    isLoadingAds = true;
    adsItems = [];
    emit(LoadingAdsState());

    await FirebaseFirestore.instance.collection("ads").get().then((value) {
      for (var element in value.docs) {
        adsItems.add(AdsModel.fromJson(element.data()));
      }
      print(adsItems.length);
      isLoadingAds = false;
      emit(GetAdsState());
    }).onError((error, stackTrace) {
      isLoadingAds = false;

      emit(FailedGetAdsState());
    });
  }

  bool isLoadingonSaleProduct = false;
  Future<void> getProductOnOffer() async {
    isLoadingonSaleProduct = true;
    offers = [];
    emit(LoadingOffersState());

    await FirebaseFirestore.instance
        .collection("products")
        .where("is_on_sale", isEqualTo: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        offers.add(ProductModel.fromJson(element.data()));
      }
      print(adsItems.length);
      isLoadingonSaleProduct = false;
      emit(GetOffersState());
    }).onError((error, stackTrace) {
      isLoadingonSaleProduct = false;

      emit(FailedGetOffersState());
    });
  }

  bool isLoadingProductMostSelling = false;
  Future<void> getProductMostSelling() async {
    bestSellingProducts = [];
    isLoadingProductMostSelling = true;
    emit(LoadingMostSellingState());

    await FirebaseFirestore.instance
        .collection("products")
        .where("is_on_sale", isEqualTo: false)
        .limit(6)
        .get()
        .then((value) {
      for (var element in value.docs) {
        bestSellingProducts.add(ProductModel.fromJson(element.data()));
      }
      print(adsItems.length);
      isLoadingProductMostSelling = false;
      emit(GetMostSellingState());
    }).onError((error, stackTrace) {
      isLoadingProductMostSelling = false;

      emit(FailedGetMostSellingState());
    });
  }

  addToCart(ProductModel product, int quantity) async {
    String? userDocID =
        await FlutterSecureStorage().read(key: StorageKey.userDocId);
    print(userDocID);
    await FirebaseFirestore.instance
        .collection("cart")
        .doc(userDocID)
        .collection("cart_products")
        .doc(product.id)
        .set({
      "id": product.id,
      "product_id": product.id,
      "quantity": quantity,
      "product_price": product.price,
      "product_name": product.title,
      "product_is_on_sale": product.isOnSale,
      "product_sale_price": product.onSalePrice,
      "product_image": product.images!.first,
    }).then((value) {
      toastApp(message: "Added to cart successfully");
    }).onError((error, stackTrace) {
      toastApp(message: "Failed to add product to cart");
    });
  }

  addToFavorite(ProductModel product) async {
    String? userDocID =
        await FlutterSecureStorage().read(key: StorageKey.userDocId);
    print(userDocID);
    await FirebaseFirestore.instance
        .collection("favorite")
        .doc(userDocID)
        .collection("favorite_products")
        .doc(product.id)
        .set({
      "id": product.id,
      "product_id": product.id,
      "product_name": product.title,
      "product_image": product.images!.first,
    }).then((value) {
      toastApp(message: "Added to Favorite successfully");
    }).onError((error, stackTrace) {
      toastApp(message: "Failed to add product to Favorite");
    });
  }
}
