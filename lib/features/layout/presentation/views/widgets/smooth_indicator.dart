import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothIndicator extends StatelessWidget {
  final PageController controller;
  const SmoothIndicator({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      axisDirection: Axis.horizontal,
      effect: SlideEffect(
        spacing: 8.0,
        radius: 25,
        dotWidth: 15,
        dotHeight: 16.0,
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 1.5,
        dotColor: Colors.grey,
        activeDotColor: AppColors.secondColor,
      ),
    );
  }
}
