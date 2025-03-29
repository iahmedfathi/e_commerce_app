import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/app_styles.dart';
import 'package:shop_app/features/checkout/presentation/widgets/intermittent_distances.dart';
import 'package:shop_app/features/checkout/presentation/widgets/invoice_details.dart';
import 'package:shop_app/features/checkout/presentation/widgets/master_card_item.dart';
import 'package:shop_app/features/checkout/presentation/widgets/pay_item.dart';
import 'package:shop_app/features/checkout/presentation/widgets/positioned_circle.dart';

class ThankViewBody extends StatelessWidget {
  const ThankViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(top: 40 + 15),
              child: Column(
                children: [
                  Text(
                    'Thank you',
                    style: AppStyles.medium25,
                  ),
                  Text(
                    'Your transaction was successful',
                    style: AppStyles.regular14,
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  InvoiceDetails(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: MasterCardItem(),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PayItem(),
                  ),
                  SizedBox(
                    height:
                        ((MediaQuery.sizeOf(context).height * .2 + 20) / 2) -
                            29,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: -50,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xffEDEDED),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: -40,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          PositionedCircle(
            leftRadiosPosition: -20,
          ),
          PositionedCircle(
            rightRadiosPosition: -20,
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.sizeOf(context).height * .2 + 20,
              child: IntermittentDistances()),
        ],
      ),
    );
  }
}
