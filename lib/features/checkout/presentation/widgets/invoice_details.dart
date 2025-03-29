import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/features/checkout/presentation/widgets/thanks_info.dart';
import 'package:shop_app/features/checkout/presentation/widgets/total_price.dart';
import 'package:shop_app/features/layout/presentation/controllers/cubit/layout_cubit.dart';

class InvoiceDetails extends StatelessWidget {
  const InvoiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ThanksInfo(
            title: "Date",
            subTitle: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          ),
          ThanksInfo(
            title: 'Time',
            subTitle: DateFormat('hh:mm a').format(DateTime.now()),
          ),
          ThanksInfo(title: 'To', subTitle: "Fashion "),
          Divider(
            height: 50,
            thickness: 2,
            color: Color(0xffC7C7C7),
          ),
          TotalPrice(
              title: 'Total', price: "${LayoutCubit.get(context).totalPrice}\$")
        ],
      ),
    );
  }
}
