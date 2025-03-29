import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/widgets/text_form_field.dart';
import 'package:shop_app/features/layout/presentation/controllers/cubit/layout_cubit.dart';
import 'package:shop_app/features/layout/presentation/views/widgets/banners_section.dart';
import 'package:shop_app/features/layout/presentation/views/widgets/products_section.dart';
import 'package:shop_app/features/layout/presentation/views/widgets/smooth_indicator.dart';
import 'package:shop_app/features/layout/presentation/views/widgets/text_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController controller = PageController();

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomFormField(
                    textAlign: TextAlign.start,
                    omnChange: (query) {
                      LayoutCubit.get(context).filterProductsByName(query);
                    },
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    hintText: 'Search',
                    filled: true,
                    fillColor: Colors.grey[100],
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                    ),
                    cursorColor: Colors.grey,
                  ),
                ),
                const SizedBox(height: 15),
                BannersSection(controller: controller),
                const SizedBox(height: 15),
                Center(child: SmoothIndicator(controller: controller)),
                // TextSection(
                //   text: "Categories",
                // ),
                // const SizedBox(height: 15),
                // CategoriesSection(),
                const SizedBox(height: 15),
                TextSection(
                  text: "Products",
                ),
                SizedBox(
                  height: 15,
                ),
                ProductsSection(),
              ],
            ),
          ),
        );
      },
    );
  }
}
