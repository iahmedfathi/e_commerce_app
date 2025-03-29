import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:shop_app/core/api/end_pointes.dart';
import 'package:shop_app/features/checkout/data/models/amount_model/amount_model.dart';
import 'package:shop_app/features/checkout/data/models/amount_model/details.dart';

import 'package:shop_app/features/checkout/data/models/items_list/items_list.dart';
import 'package:shop_app/features/checkout/presentation/views/thank_you_view.dart';
import 'package:shop_app/features/layout/data/models/product_model.dart';
import 'package:shop_app/features/layout/presentation/controllers/cubit/layout_cubit.dart';



void executePaypalPayment(BuildContext context,
    ({AmountModel amount, ItemsList itemsList}) transactionData) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (BuildContext context) => PaypalCheckoutView(
      sandboxMode: true,
      clientId: ApiKey.clientId,
      secretKey: ApiKey.payPalSecretKey,
      transactions: [
        {
          "amount": transactionData.amount.toJson(),
          "description": "The payment transaction description.",
          "item_list":  transactionData.itemsList.toJson()
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        log("onSuccess: $params");
        Navigator.push(context, MaterialPageRoute(builder: (context) => ThankYouView()));
      },
      onError: (error) {
        log("onError: $error");
        Navigator.pop(context);
      },
      onCancel: () {
        log('cancelled:');
        Navigator.pop(context);
      },
    ),
  ));
}

({AmountModel amount, ItemsList itemsList}) getTransactionData(BuildContext context) {
  var amount = AmountModel(
      currency: 'USD',
      total: LayoutCubit.get(context).totalPrice.toString(),
      details: Details(
        subtotal: LayoutCubit.get(context).totalPrice.toString(), 
        shipping: '0', 
        shippingDiscount: 0
      ));

  // Extract products from the cart and convert to PayPal's format
  List<ProductModel> orders = LayoutCubit.get(context).cartProducts.map((cartItem) {
    return ProductModel(
      name: cartItem.name,
      price: cartItem.price,
    );
  }).toList();

  var itemsList = ItemsList(orders: orders);

  return (amount: amount, itemsList: itemsList);
}
