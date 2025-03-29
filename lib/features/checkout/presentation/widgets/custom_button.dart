
import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, this.onPressed, required this.text, this.isLoading = false});
  final void Function()? onPressed;
  final String text;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color:AppColors.mainColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
          onPressed: onPressed,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Text(
                  text,
                  style: AppStyles.medium22,
                )),
    );
  }
}
