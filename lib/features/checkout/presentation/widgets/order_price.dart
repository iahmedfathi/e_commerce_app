
import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/app_styles.dart';

class OrderPrice extends StatelessWidget {
  const OrderPrice({super.key, required this.title, required this.price});
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyles.regular18,
        ),
        Text(
          price,
          style: AppStyles.regular18,
        ),
      ],
    );
  }
}
