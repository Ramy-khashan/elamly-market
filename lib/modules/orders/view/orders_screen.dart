import 'package:elamlymarket/core/components/loading_item.dart';
import 'package:elamlymarket/core/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/my_string.dart';
import '../controller/orders_cubit.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit()..getOrders(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Orders',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 23),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            final controller = OrdersCubit.get(context);
            return controller.isLoadingOrders
                ? LoadingItem()
                : controller.ordersitems.isEmpty
                    ? Center(
                        child: Text("No orders yet, Start Shopping now!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: MyStrings.fontFamily,
                                fontSize: 27,
                                fontWeight: FontWeight.bold)),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          controller.getOrders();
                        },
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.ordersitems.length,
                            itemBuilder: (context, index) => Card(
                                  margin: EdgeInsets.all(5),
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          dense: true,
                                          title: SelectableText("Order Id : " +
                                              (controller.ordersitems[index]
                                                      .orderId ??
                                                  "")),
                                          subtitle: Text(controller
                                                      .ordersitems[index]
                                                      .createdAt ==
                                                  null
                                              ? ""
                                              : DateFormat(
                                                      "EEEE MM, yyyy - hh:mm a")
                                                  .format(DateTime.parse(
                                                      controller
                                                          .ordersitems[index]
                                                          .createdAt!))),
                                        ),
                                        ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: controller
                                                .ordersitems[index]
                                                .products!
                                                .length,
                                            itemBuilder: (context, i) =>
                                                ListTile(
                                                  leading: SelectableText(
                                                      "(${controller.ordersitems[index].products![i].quantity.toString()}x)"),
                                                  title: SelectableText(
                                                      controller
                                                          .ordersitems[index]
                                                          .products![i]
                                                          .productTitle
                                                          .toString()),
                                                  trailing: SelectableText(
                                                      (controller
                                                                  .ordersitems[
                                                                      index]
                                                                  .products![i]
                                                                  .price ??
                                                              '') +
                                                          " L.E"),
                                                  subtitle:
                                                      Text("Price Per 1 Qty"),
                                                )),
                                        SelectableText(
                                          "Code : ${controller.ordersitems[index].code}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 21),
                                        ),
                                        Row(
                                          children: [
                                            Text("Delivery Fees : "),
                                            Spacer(),
                                            Text(controller.ordersitems[index]
                                                    .deliveryFees
                                                    .toString() +
                                                " L.E")
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Text("Total Price : "),
                                            Spacer(),
                                            Text(controller.ordersitems[index]
                                                    .totalPrice
                                                    .toString() +
                                                " L.E")
                                          ],
                                        ),
                                        Divider(
                                          color: MyColors.greenColor,
                                        ),
                                        controller
                                                .ordersitems[index].isCancelled!
                                            ? Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Order Canceled : "),
                                                      Spacer(),
                                                      Text(
                                                        " Cancelled  ",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      ),
                                                      Icon(
                                                        Icons.dangerous,
                                                        color: Colors.red,
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                        child: Text(
                                                      controller
                                                          .ordersitems[index]
                                                          .cancelReason
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red,
                                                          fontSize: 18),
                                                    )),
                                                  )
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  Text("Order Status : "),
                                                  Spacer(),
                                                  controller.ordersitems[index]
                                                          .isPaid!
                                                      ? Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "Order Delivered ",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            ),
                                                            CircleAvatar(
                                                                backgroundColor:
                                                                    MyColors
                                                                        .greenColor,
                                                                child: Icon(
                                                                  Icons.done,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                          ],
                                                        )
                                                      : Column(
                                                          children: [
                                                            Text(
                                                              "In Progress",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            SizedBox(
                                                              width: 100,
                                                              child:
                                                                  LinearProgressIndicator(),
                                                            ),
                                                          ],
                                                        )
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                )),
                      );
          },
        ),
      ),
    );
  }
}
