
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:shop_app/core/utils/app_styles.dart';


class PayItem extends StatelessWidget {
  const PayItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 50,
      children: [
        Icon(
          FontAwesomeIcons.barcode,
          size: 70,
        ),
        Container(
          width: 115,
          height: 58,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.green, width: 1.5),
                borderRadius: BorderRadius.circular(15)),
          ),
          child: Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'PAID',
                    style: AppStyles.semiBold24,
                  ))),
        )
      ],
    );
  }
}
