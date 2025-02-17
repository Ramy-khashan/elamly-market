import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import '../../../core/components/loading_item.dart';
import '../../../core/utils/my_colors.dart';
import '../../../core/utils/my_string.dart';

import '../../add_edit_address/view/add_edit_address.dart';
import '../controller/delivery_address_cubit.dart';

class DeliveryAddressScreen extends StatelessWidget {
  const DeliveryAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveryAddressCubit()..getDeliveryAddress(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Delivery Address",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).brightness.index == 1
                    ? MyColors.blackColor
                    : MyColors.whiteColor),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddEditAddressScreen(isAddAddress: true),
                      )).then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeliveryAddressScreen()));
                  });
                },
                child: Text(
                  "Add Address",
                  style: TextStyle(
                    fontFamily: MyStrings.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ))
          ],
        ),
        body: BlocBuilder<DeliveryAddressCubit, DeliveryAddressState>(
          builder: (context, state) {
            final controller = DeliveryAddressCubit.get(context);
            return controller.isLoading
                ? LoadingItem()
                : controller.deliveryAddress.isEmpty
                    ? Center(
                        child: Text("No delivery addresses exist",
                            style: TextStyle(
                                fontFamily: MyStrings.fontFamily,
                                fontSize: 27,
                                fontWeight: FontWeight.bold)),
                      )
                    : ListView.builder(
                        itemCount: controller.deliveryAddress.length,
                        itemBuilder: (context, index) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DefaultTextStyle(
                              style: TextStyle(
                                  color: Theme.of(context).brightness.index == 1
                                      ? MyColors.blackColor
                                      : MyColors.whiteColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: MyStrings.fontFamily),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name : ${controller.deliveryAddress[index].fullName}",
                                  ),
                                  Text(
                                    "Phone : ${controller.deliveryAddress[index].phone1}",
                                  ),
                                  Text(
                                    "Phone2 : ${controller.deliveryAddress[index].phone2!.isEmpty ? "Not Exists" : controller.deliveryAddress[index].phone2}",
                                  ),
                                  Text(
                                    "Address : ${controller.deliveryAddress[index].fullAddress}",
                                  ),
                                  Text(
                                    "Land Mark : ${controller.deliveryAddress[index].landmark}",
                                  ),
                                  controller.deliveryAddress[index].latitude ==
                                              null ||
                                          controller.deliveryAddress[index]
                                              .latitude!.isEmpty
                                      ? SizedBox()
                                      : ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.grey,
                                          elevation: 6,
                                          backgroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(horizontal: 20)
                                        ),
                                          onPressed: () {
                                            showBottomSheet(

                                                enableDrag: true,
                                                context: context,
                                                builder: (context) => Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Align(
                                                            alignment: AlignmentDirectional.topEnd,
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: Icon(
                                                                  Icons.close,
                                                                  color:
                                                                      Colors.red,
                                                                )),
                                                          ),
                                                          Expanded(
                                                            child: OpenStreetMapSearchAndPick(
                                                              isWithButton: false,
                                                              center: LatLong(
                                                                  double.parse(controller
                                                                      .deliveryAddress[
                                                                          index]
                                                                      .latitude
                                                                      .toString()),
                                                                  double.parse(controller
                                                                      .deliveryAddress[
                                                                          index]
                                                                      .longitude
                                                                      .toString())),
                                                              buttonColor:
                                                                  Colors.blue,
                                                              onPicked: (PickedData
                                                                  pickedData) {},
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ));
                                          },
                                          icon: Icon(Icons.location_on,color: Colors.black,),
                                          label: Text("Your location",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // InkWell(
                                        //   borderRadius:
                                        //       BorderRadius.circular(5),
                                        //   onTap: () {},
                                        //   child: Card(
                                        //     color: MyColors.greenColor,
                                        //     child: Padding(
                                        //       padding:
                                        //           const EdgeInsets.symmetric(
                                        //               horizontal: 12,
                                        //               vertical: 8),
                                        //       child: Text(
                                        //         "Set Default",
                                        //         style: TextStyle(
                                        //           fontFamily:
                                        //               MyStrings.fontFamily,
                                        //           color: MyColors.whiteColor,
                                        //           fontWeight: FontWeight.w700,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),

                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddEditAddressScreen(
                                                          deliveryAddressModel:
                                                              controller
                                                                      .deliveryAddress[
                                                                  index],
                                                          isAddAddress: false),
                                                )).then((value) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DeliveryAddressScreen()));
                                            });
                                          },
                                          child: Card(
                                            color: MyColors.greenColor,
                                            elevation: 5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.edit,
                                                    size: 17,
                                                  ),
                                                  Text(
                                                    "  Edit",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          MyStrings.fontFamily,
                                                      color:
                                                          MyColors.whiteColor,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
          },
        ),
      ),
    );
  }
}
