import 'package:flutter/material.dart';
import 'package:shop_app/features/checkout/presentation/widgets/custom_button_bloc_consumer.dart';
import 'package:shop_app/features/checkout/presentation/widgets/pay_item_list_view.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  State<PaymentMethodsBottomSheet> createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  int selectedIndex = 0; // Default to credit card
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pass the selectedIndex and update function
            PayItemListView(
              selectedIndex: selectedIndex,
              onSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            SizedBox(height: 20),
            // Pass selectedIndex to button consumer
            CustomButtonBlocConsumer(selectedIndex: selectedIndex),
          ],
        ),
      ),
    );
  }
}
