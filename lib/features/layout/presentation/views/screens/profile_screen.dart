import 'package:flutter/material.dart';
import 'package:shop_app/features/layout/presentation/views/widgets/profile_view_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileViewBody(),
    );
  }
}
