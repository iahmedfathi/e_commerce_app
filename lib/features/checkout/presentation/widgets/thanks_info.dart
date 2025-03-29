import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/app_styles.dart';

class ThanksInfo extends StatelessWidget {
  const ThanksInfo({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

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
          subTitle,
          style: AppStyles.semiBod18,
        ),
      ],
    );
  }
}
