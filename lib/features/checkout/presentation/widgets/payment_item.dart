import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem({super.key, required this.image, this.isActive = false});
  final String image;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: 103,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                blurRadius: 1.5,
                color: isActive ? Color(0xff34A853) : Color(0xffD9D9D9))
          ]),
      child: Center(
          child: SvgPicture.asset(
        image,
        height: 24,
        fit: BoxFit.scaleDown,
      )),
    );
  }
}
