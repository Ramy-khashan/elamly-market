import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket/core/utils/storage_key.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/favorite_product_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial()) {
    getFavoriteProducts();
  }
  static FavoriteCubit get(context) => BlocProvider.of(context);
  List<FavoriteProductModel> favoriteProducts = [];
  bool isLoadingFavoritie = false;
  String? userDocID;
  getFavoriteProducts() async {
    isLoadingFavoritie = true;
    favoriteProducts = [];
    emit(LoadingGetFavoriteState());

    try {
      userDocID = await FlutterSecureStorage().read(key: StorageKey.userDocId);
      await FirebaseFirestore.instance
          .collection("favorite")
          .doc(userDocID)
          .collection("favorite_products")
          .get()
          .then((value) {
       
        value.docs.forEach((doc) {
          favoriteProducts.add(FavoriteProductModel.fromJson(doc.data()));
        });
        isLoadingFavoritie = false;

        emit(GetFavoriteSuccessfullyState());
      }).onError((error, stackTrace) {
        isLoadingFavoritie = false;

        emit(FailedGetFavoriteState());
      });
    } catch (e) {
      isLoadingFavoritie = false;

      emit(FailedGetFavoriteState());
    }
  }

  deleteItem({required int index}) {
    emit(StartDeleteFavoriteItemState());
    String cartItemId = favoriteProducts[index].id ?? "";
    favoriteProducts.removeAt(index);
    FirebaseFirestore.instance
        .collection("favorite")
        .doc(userDocID)
        .collection("favorite_products")
        .doc(cartItemId)
        .delete();
    if (index == 0) {
      getFavoriteProducts();
    }
    emit(DeleteFavoritetemState());
  }
}
