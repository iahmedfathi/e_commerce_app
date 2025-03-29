import 'package:shop_app/features/layout/data/models/product_model.dart';



class ItemsList {
  List<ProductModel>? orders;

  ItemsList({this.orders});

  factory ItemsList.fromJson(Map<String, dynamic> json) => ItemsList(
        orders: (json["data"]["cart_items"] as List<dynamic>?)
            ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
  'items': orders?.map((order) {
    return {
      'name': order.name,
      'quantity': 1, // Since no quantity is available in ProductModel, set default 1
      'price': order.price?.toString() ?? "0",
      'currency': 'USD'
    };
  }).toList()
};
}
