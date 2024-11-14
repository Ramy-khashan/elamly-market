import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/my_colors.dart';
import '../../../../core/utils/my_string.dart';
import '../../../add_edit_address/view/add_edit_address.dart';
import '../../controller/checkout_cubit.dart';
import '../../model/summary_product_model.dart';
import '../checkout_screen.dart';

class DeliveryAddressShape extends StatelessWidget {
  const DeliveryAddressShape(
      {super.key, required this.index, required this.product});
  final int index;
  final List<SummaryProductModel> product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final controller = CheckoutCubit.get(context);
        return InkWell(
            onTap: () {},
            child: Row(
              children: [
                Radio.adaptive(
                    value: index,
                    groupValue: controller.selectedDeliveryAddress,
                    onChanged: (val) {
                      controller.onSelectDeliveryAddress(val);
                    }),
                Expanded(
                  child: Card(
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
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(5),
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
                                                    CheckoutScreen(
                                                      product: product,
                                                    )));
                                      });
                                    },
                                    child: Card(
                                      color: MyColors.greenColor,
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
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
                                                color: MyColors.whiteColor,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
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
                )
              ],
            ));
      },
    );
  }
}
