import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/utils/storage_key.dart';
import '../model/order_model.dart';
part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());
  static OrdersCubit get(context) => BlocProvider.of(context);
  List<OrdersModel> ordersitems = [];
  bool isLoadingOrders = false;
  String? userDocID;

  getOrders() async {
    isLoadingOrders = true;
    ordersitems = [];
    emit(LoadingOrdersState());
    userDocID = await FlutterSecureStorage().read(key: StorageKey.userDocId);

    FirebaseFirestore.instance
        .collection("orders")
        .where("user_id", isEqualTo: userDocID)
        .limit(8000)
        .get()
        .then((value) {
      print(value.docs.length);
      for (var element in value.docs) {
        OrdersModel order = OrdersModel.fromJson(element.data());
        order.orderId = element.id;
        ordersitems.add(order);
      }
     
      isLoadingOrders = false;
      emit(GetOrdersState());
    }).onError((error, stackTrace) {
      isLoadingOrders = false;
      print(error.toString());
      emit(FailedGetOrdersState());
    });
    
  }
}
