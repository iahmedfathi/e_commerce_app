import 'package:flutter/cupertino.dart';
import 'package:shop_app/core/utils/app_colors.dart';

class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.mainColor),
        ),
        Text(
          '',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.secondColor),
        ),
      ],
    );
  }
}
