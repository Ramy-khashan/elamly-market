import 'package:elamlymarket/core/components/loading_item.dart';
import 'package:elamlymarket/core/utils/validate.dart';
import 'package:elamlymarket/modules/add_edit_address/model/delivery_address_model.dart';
import 'package:elamlymarket/modules/add_edit_address/view/widgets/address_shape_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import '../../../core/components/app_text_field.dart';

import '../../../core/utils/my_colors.dart';
import '../controller/add_edit_address_cubit.dart';

class AddEditAddressScreen extends StatelessWidget {
  const AddEditAddressScreen(
      {super.key, required this.isAddAddress, this.deliveryAddressModel});
  final bool isAddAddress;
  final DeliveryAddressModel? deliveryAddressModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditAddressCubit(
          isAddAddress: isAddAddress,
          deliveryAddressModel: deliveryAddressModel),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            isAddAddress ? "Add" : "Edit",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 23,
                color: Theme.of(context).brightness.index == 1
                    ? MyColors.blackColor
                    : MyColors.whiteColor),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocBuilder<AddEditAddressCubit, AddEditAddressState>(
            builder: (context, state) {
              final controller = AddEditAddressCubit.get(context);
              return Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          AppTextField(
                            controller: controller.fullName,
                            onValidate: (val) => Validate.notEmpty(val),
                            label: "Full Name",
                          ),
                          AppTextField(
                              controller: controller.phone1,
                              onValidate: (val) =>
                                  Validate.validateEgyptPhoneNumber(val),
                              label: "Phone Number"),
                          AppTextField(
                              controller: controller.phone2,
                              onValidate: (val) => val.toString().isEmpty
                                  ? null
                                  : Validate.validateEgyptPhoneNumber(val),
                              label: "Phone Number 2"),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        backgroundColor:
                                            MyColors.searchBarColor),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) => Card(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                child:
                                                    OpenStreetMapSearchAndPick(
                                                        center:
                                                            controller.location,
                                                        buttonColor:
                                                            Colors.blue,
                                                        buttonText:
                                                            'Set Your Location',
                                                        onPicked: (pickedData) {
                                                          controller
                                                              .getLocationAndAddress(
                                                                  pickedData,
                                                                  context);
                                                        }),
                                              ));
                                    },
                                    child: Text(
                                      "Adding Address Location",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              AlertDialog.adaptive(
                                                content: Text(
                                                    "This optional to set your location on map"),
                                              ));
                                    },
                                    icon: Icon(Icons.help))
                              ],
                            ),
                          ),
                          AddressShapeDataItem(
                              title: "Latitude", value: controller.latitude),
                          AddressShapeDataItem(
                              title: "Longitude", value: controller.longitude),
                          AppTextField(
                              controller: controller.fullAddress,
                              onValidate: (val) => Validate.notEmpty(val),
                              maxLines: 3,
                              label: "Full Address"),
                          AppTextField(
                            controller: controller.landMark,
                            onValidate: (val) => Validate.notEmpty(val),
                            label: "Land Mark",
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: controller.isLoading
                            ? LoadingItem()
                            : ElevatedButton(
                                onPressed: () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    isAddAddress
                                        ? controller.addToDeliveryAddress()
                                        : controller.editDeliveryAddress(
                                            deliveryAddressModel:
                                                deliveryAddressModel!);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    backgroundColor: MyColors.searchBarColor),
                                child: Text(
                                  isAddAddress ? "Add" : "Edit",
                                  style: TextStyle(
                                      color: MyColors.greenColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                )))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
