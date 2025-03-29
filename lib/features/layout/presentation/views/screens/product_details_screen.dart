import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/features/layout/presentation/controllers/cubit/layout_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int? productId;

  const ProductDetailsScreen({super.key, this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    final layoutCubit = BlocProvider.of<LayoutCubit>(context);
    layoutCubit.getProductsDetails(productId: widget.productId!);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (state is ProductDetailsFailure) {
          return Center(child: Text("Error: ${state.errorMessage}"));
        } else if (state is ProductDetailsSuccess) {
          final product = state.product;

          return Scaffold(
            appBar: AppBar(
                backgroundColor: AppColors.thirdColor,
                title: Text(
                  product.name!,
                  style: TextStyle(color: AppColors.mainColor, fontSize: 16),
                )),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: product.image!,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        )),
                    Card(
                      color: AppColors.mainColor,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: 20,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Price: ${product.price!}\$",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    product.price == product.oldPrice
                                        ? ""
                                        : "oldPrice: ${product.oldPrice!}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.white),
                                  ),
                                ],
                              ),
                              Divider(
                                  indent: 30,
                                  endIndent: 30,
                                  color: Colors
                                      .white), // Line between title & subtitle
                              Text(
                                "Description: ${product.description!}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
