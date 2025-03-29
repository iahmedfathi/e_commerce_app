import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/features/layout/presentation/controllers/cubit/layout_cubit.dart';
import 'package:shop_app/features/layout/presentation/views/screens/categories_details_screen.dart';
import 'package:shop_app/features/layout/presentation/views/screens/product_details_screen.dart';
import 'package:shop_app/features/layout/presentation/views/widgets/price_widget.dart';

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = LayoutCubit.get(context);
        final favProducts = cubit.favoriteProducts;

        if (favProducts.isEmpty) {
          return Center(
            child: Text(
              'No favorites yet',
              style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: favProducts.length,
            itemBuilder: (context, index) {
              final favProduct = favProducts[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoriesDetailsScreen(
                                categoriesId: favProduct.id!,
                              )));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                  productId: favProduct.id),
                            ),
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: favProduct.image!,
                          height: 120,
                          width: 100,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              favProduct.name ?? "No Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.mainColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            PriceWidget(
                              price: "${favProduct.price ?? 0} \$",
                              oldPrice: favProduct.price == favProduct.oldPrice
                                  ? ""
                                  : "${favProduct.oldPrice ?? 0} \$",
                            ),
                            MaterialButton(
                              color: AppColors.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              onPressed: () {
                                final cubit = context.read<LayoutCubit>();
                                cubit.addOrDelateFavProduct(
                                    productId: favProduct.id.toString());
                              },
                              child: const Text(
                                'Remove',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
