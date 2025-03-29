
import 'package:flutter/material.dart';
import 'package:shop_app/features/checkout/presentation/widgets/payment_item.dart';

class PayItemListView extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelected;

  const PayItemListView({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> payItems = const [
    'assets/images/credit.svg',
    "assets/images/paypal.svg"
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 63,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: payItems.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () {
              onSelected(index); // Update the selected index
            },
            child: PaymentItem(
              isActive: selectedIndex == index, // Highlight selection
              image: payItems[index],
            ),
          ),
        ),
      ),
    );
  }
}
