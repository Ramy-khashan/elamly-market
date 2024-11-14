import 'package:elamlymarket/modules/checkout/model/summary_product_model.dart';

class SummaryModel {
  final List<SummaryProductModel> summaryProducts;
  final String deliveryFees;
  final String totalPrice;

  SummaryModel({required this.summaryProducts, required this.deliveryFees, required this.totalPrice});
}
