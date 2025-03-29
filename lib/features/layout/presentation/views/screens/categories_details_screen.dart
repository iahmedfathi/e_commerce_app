import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utils/app_colors.dart';

import 'package:shop_app/features/layout/presentation/controllers/cubit/layout_cubit.dart';
import 'package:shop_app/features/layout/presentation/views/screens/product_details_screen.dart';
import 'package:shop_app/features/layout/presentation/views/widgets/price_widget.dart';

class CategoriesDetailsScreen extends StatefulWidget {
  const CategoriesDetailsScreen({super.key, required this.categoriesId});
  final int categoriesId;

  @override
  State<CategoriesDetailsScreen> createState() =>
      _CategoriesDetailsScreenState();
}

class _CategoriesDetailsScreenState extends State<CategoriesDetailsScreen> {
  @override
  void initState() {
    super.initState();
    final layoutCubit = LayoutCubit.get(context);
    layoutCubit.getCategoriesDetails(categoriesId: widget.categoriesId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        if (state is CategoriesDetailsLoadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (state is CategoriesDetailsFailureState) {
          return Center(child: Text("Error: ${state.errorMessage}"));
        } else if (state is CategoriesDetailsSuccessState) {
          final categories = state.categoriesDetailsModels;

          return Scaffold(
            appBar: AppBar(
                backgroundColor: AppColors.thirdColor,
                title: Text(
                  categories.isNotEmpty ? categories.length.toString() : '',
                  style: TextStyle(color: AppColors.mainColor, fontSize: 16),
                )),
            body: categories.isEmpty
                ? Center(child: Text("no categories selected"))
                : ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      return Container(
                        margin: EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailsScreen(
                                                      productId:
                                                          category.id!)));
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: category.image!,
                                      height: 120,
                                      width: 100,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    category.name!,
                                    style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                  ),
                                  PriceWidget(
                                      price: "${category.price}\$",
                                      oldPrice:
                                          category.price == category.oldPrice
                                              ? ""
                                              : "${category.oldPrice}\$"),
                                  Text(
                                    category.description!,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(color: AppColors.mainColor),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      );
                    }),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
