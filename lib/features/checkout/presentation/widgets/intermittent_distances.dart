import 'package:flutter/material.dart';

class IntermittentDistances extends StatelessWidget {
  const IntermittentDistances({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: List.generate(
            20,
            (index) => Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    height: 2,
                    width: 1,
                    color: Color(0xffB8B8B8),
                  ),
                ))),
      ),
    );
  }
}
