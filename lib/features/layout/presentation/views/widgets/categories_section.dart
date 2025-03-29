import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/layout/presentation/controllers/cubit/layout_cubit.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(builder: (context, state) {
      final cubit = LayoutCubit.get(context);
      final categories = cubit.categories;

      return SizedBox(
        height: 80,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(width: 15),
          padding: EdgeInsets.only(right: 5),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CircleAvatar(
              backgroundImage: NetworkImage(category.image!),
              radius: 25,
            );
          },
        ),
      );
    });
  }
}
