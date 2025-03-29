import 'package:flutter/material.dart';
import 'package:shop_app/features/layout/presentation/views/widgets/favorites_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FavoritesWidget(),
    );
  }
}
