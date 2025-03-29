import 'package:flutter/material.dart';

class PositionedCircle extends StatelessWidget {
  const PositionedCircle({
    super.key,
    this.rightRadiosPosition,
    this.leftRadiosPosition,
  });
  final double? rightRadiosPosition;
  final double? leftRadiosPosition;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.sizeOf(context).height * .2,
      left: leftRadiosPosition,
      right: rightRadiosPosition,
      child: CircleAvatar(
        backgroundColor: Colors.white,
      ),
    );
  }
}
