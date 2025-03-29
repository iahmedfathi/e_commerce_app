
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/core/utils/app_styles.dart';

class MasterCardItem extends StatelessWidget {
  const MasterCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 305,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          spacing: 50,
          children: [
            SvgPicture.asset(
              "assets/images/logoformaster.svg",
              height: 35,
              width: 21,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Credit Card',
                    style: AppStyles.regular18,
                  ),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child:
                          Text('Mastercard*****', style: AppStyles.regular16)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
