import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket/market.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../../../core/components/toast_app.dart';
import '../../../core/utils/storage_key.dart';
import '../model/delivery_address_model.dart';

part 'add_edit_address_state.dart';

class AddEditAddressCubit extends Cubit<AddEditAddressState> {
  AddEditAddressCubit(
      {required bool isAddAddress,
      required DeliveryAddressModel? deliveryAddressModel})
      : super(AddEditAddressInitial()) {
    if (!isAddAddress) {
      editInfo(deliveryAddressModel: deliveryAddressModel!);
    }
  }
  static AddEditAddressCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController fullName = TextEditingController();
  TextEditingController phone1 = TextEditingController();
  TextEditingController phone2 = TextEditingController();
  TextEditingController fullAddress = TextEditingController();
  TextEditingController landMark = TextEditingController();
  addToDeliveryAddress() async {
    isLoading = true;
    emit(LoadingAddEditAddEditAddressState());
    String? userDocID =
        await FlutterSecureStorage().read(key: StorageKey.userDocId);
    Random random = Random();
    String id =
        String.fromCharCodes(List.generate(15, (_) => random.nextInt(26) + 65));

    await FirebaseFirestore.instance
        .collection("delivery_address")
        .doc(userDocID)
        .collection("user_delivery_address")
        .doc(id)
        .set({
      "id": id,
      "full_name": fullName.text,
      "phone1": phone1.text,
      "phone2": phone2.text,
      "full_address": fullAddress.text,
      "landmark": landMark.text,
      "is_defualt": false,
      "latitude": latitude,
      "longitude": longitude,
    }).then((value) {
      isLoading = false;
      emit(AddEditAddEditAddressState());

      toastApp(message: "Added to delivery address successfully");
      Navigator.pop(Market.navigatorKet.currentContext!);
    }).onError((error, stackTrace) {
      toastApp(message: "Failed to add to delivery address");
      isLoading = false;
      emit(FailedAddEditAddEditAddressState());
    });
  }

  editInfo({required DeliveryAddressModel deliveryAddressModel}) {
    fullName.text = deliveryAddressModel.fullName ?? "";
    phone1.text = deliveryAddressModel.phone1 ?? "";

    phone2.text = deliveryAddressModel.phone2 ?? "";
    fullAddress.text = deliveryAddressModel.fullAddress ?? "";
    landMark.text = deliveryAddressModel.landmark ?? "";
    latitude = deliveryAddressModel.latitude.toString();
    longitude = deliveryAddressModel.longitude.toString();
    // formKey.currentState!.validate();
  }

  editDeliveryAddress(
      {required DeliveryAddressModel deliveryAddressModel}) async {
    isLoading = true;
    emit(LoadingAddEditAddEditAddressState());

    String? userDocID =
        await FlutterSecureStorage().read(key: StorageKey.userDocId);

    await FirebaseFirestore.instance
        .collection("delivery_address")
        .doc(userDocID)
        .collection("user_delivery_address")
        .doc(deliveryAddressModel.id)
        .update({
      "full_name":
          fullName.text.isEmpty ? deliveryAddressModel.fullName : fullName.text,
      "phone1": phone1.text.isEmpty ? deliveryAddressModel.phone1 : phone1.text,
      "phone2": phone2.text.isEmpty ? deliveryAddressModel.phone2 : phone2.text,
      "full_address": fullAddress.text.isEmpty
          ? deliveryAddressModel.fullAddress
          : fullAddress.text,
      "landmark":
          landMark.text.isEmpty ? deliveryAddressModel.landmark : landMark.text,
      "latitude": latitude,
      "longitude": longitude,
    }).then((value) {
      isLoading = false;
      emit(AddEditAddEditAddressState());

      toastApp(message: "Added to delivery address successfully");
      Navigator.pop(Market.navigatorKet.currentContext!);
    }).onError((error, stackTrace) {
      toastApp(message: "Failed to add to delivery address");
      isLoading = false;
      emit(FailedAddEditAddEditAddressState());
    });
  }

  LatLong location = const LatLong(30.97239231796135, 31.323342622493566);

  String latitude = "";
  String longitude = "";
  getLocationAndAddress(PickedData locationData, context) {
    emit(GetLocationData());

    latitude = locationData.latLong.latitude.toString();
    longitude = locationData.latLong.longitude.toString();

    // fullAddress.text = locationData.address.values.toString();
    emit(SetLocationData());
    Navigator.pop(context);
  }
}
