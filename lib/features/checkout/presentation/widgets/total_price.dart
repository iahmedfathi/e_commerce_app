
import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/app_styles.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({super.key, required this.title, required this.price});
  final String title;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyles.semiBold24,
        ),
        Text(
          price,
          style: AppStyles.semiBold24,
        ),
      ],
    );
  }
}
