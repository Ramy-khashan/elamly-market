import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
 
import '../../home/model/category.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreInitial());

  List<CategoryModel> categoriesItems = [
 
  ];
  
 
    bool isLoadingCategories = false;
  Future<void> getCategories() async {
    categoriesItems = [];
    isLoadingCategories = true;
    emit(LoadingCategoriesState());

    await FirebaseFirestore.instance
        .collection("category")
       
        .limit(100)
        .get()
        .then((value) {
      for (var element in value.docs) {
        categoriesItems.add(CategoryModel.fromJson(element.data()));
      }
       isLoadingCategories = false;
      emit(GetCategoriesState());
    }).onError((error, stackTrace) {
      isLoadingCategories = false;

      emit(FailedGetCategoriesState());
    });
  }
}
