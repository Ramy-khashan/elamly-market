class SummaryProductModel {
  final String title;
  final String quantity;
  final String price;
  final bool isOnSale;
  final String priceBefore;
  final String productId;

  SummaryProductModel(
      {required this.title,
       required this.quantity, 
       required this.isOnSale, 
       required this.priceBefore, 
       required this.productId, 
      required this.price});
}
