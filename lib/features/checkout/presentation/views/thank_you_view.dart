import 'package:flutter/material.dart';

import 'package:shop_app/features/checkout/presentation/widgets/thank_view_body.dart';
class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(child: ThankViewBody()),
    );
  }
}
