import 'package:flutter/material.dart';
import 'package:shop_app/features/checkout/presentation/widgets/cart_view_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CartViewBody());
  }
}
