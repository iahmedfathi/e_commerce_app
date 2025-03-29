import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/app_colors.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.price,
    required this.oldPrice,
  });
  final String price;
  final String oldPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Text(
          price,
          style: TextStyle(fontSize: 12, color: AppColors.mainColor),
          maxLines: 2,
        ),
        Text(
          oldPrice,
          style: TextStyle(
              fontSize: 12,
              color: AppColors.mainColor,
              decoration: TextDecoration.lineThrough),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
