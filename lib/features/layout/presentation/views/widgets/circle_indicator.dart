import 'package:flutter/material.dart';

class CircleIndicator extends StatelessWidget {
  const CircleIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
