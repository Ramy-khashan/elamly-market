import 'package:elamlymarket/core/components/app_button.dart';
import 'package:elamlymarket/core/components/loading_item.dart';
import 'package:elamlymarket/modules/checkout/model/summary_product_model.dart';
import 'package:elamlymarket/modules/checkout/view/widgets/delivert_address_shape.dart';
import 'package:elamlymarket/modules/checkout/view/widgets/summary_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/my_colors.dart';
import '../../../core/utils/my_string.dart';
import '../../add_edit_address/view/add_edit_address.dart';
import '../../delivery_address/view/delivery_address_screen.dart';
import '../controller/checkout_cubit.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.product});
  final List<SummaryProductModel> product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit()..getDeliveryAddress()..getDeliveryFees(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Checkout',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 23),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    SummaryPart(
                      product: product,
                    ),
                    BlocBuilder<CheckoutCubit, CheckoutState>(
                      builder: (context, state) {
                        final controller = CheckoutCubit.get(context);
                        return controller.isLoading
                            ? LoadingItem()
                            : controller.deliveryAddress.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("No delivery addresses exist",
                                            style: TextStyle(
                                                fontFamily: MyStrings.fontFamily,
                                                fontSize: 27,
                                                fontWeight: FontWeight.bold)),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 20),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20)),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddEditAddressScreen(
                                                            isAddAddress: true),
                                                  )).then((value) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DeliveryAddressScreen()));
                                              });
                                            },
                                            child: Center(
                                              child: Text(
                                                "Add Delivery Address",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
                                          children: [
                                            Text("Delivery Address",
                                                style: TextStyle(
                                                    fontFamily:
                                                        MyStrings.fontFamily,
                                                    fontSize: 27,
                                                    fontWeight: FontWeight.bold)),
                                            Spacer(),
                                            IconButton(
                                                onPressed: () {
                                                  controller
                                                      .toggleDeliveryAddress();
                                                },
                                                icon: Icon(controller
                                                        .isToggledDeliveryAddress
                                                    ? Icons.arrow_drop_up_rounded
                                                    : Icons
                                                        .arrow_drop_down_rounded,color: MyColors.orangeColor,))
                                          ],
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 500),
                                        height: controller
                                                .isToggledDeliveryAddress
                                            ? 0
                                            : controller.deliveryAddress.length *
                                                165,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            
                                            itemCount:
                                                controller.deliveryAddress.length,
                                            itemBuilder: (context, index) =>
                                                DeliveryAddressShape(
                                                    product: product,
                                                    index: index)),
                                      ),
                                    ],
                                  );
                      },
                    )
                  ],
                ),
              )),
              BlocBuilder<CheckoutCubit, CheckoutState>(
                builder: (context, state) {
                  final controller = CheckoutCubit.get(context);
          
                  return controller.selectedDeliveryAddress == null
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          child: controller.isLoadingCreateOrder
                              ? LoadingItem()
                              : AppButton(
                               
                                  onPressed: () {
                                    controller.createOrder(product: product);
                                  },
                                  buttonText: 
                                      "Create Order",
                                    
                               
                                  
                                ),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
