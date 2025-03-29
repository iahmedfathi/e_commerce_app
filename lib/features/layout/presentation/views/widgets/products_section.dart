import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/layout/data/models/product_model.dart';
import 'package:shop_app/features/layout/presentation/controllers/cubit/layout_cubit.dart';
import 'package:shop_app/features/layout/presentation/views/widgets/item_widget.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key, this.productModel});
  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if (state is ProductsFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<LayoutCubit, LayoutState>(builder: (context, state) {
          final cubit = LayoutCubit.get(context);

          final products = cubit.products;

          return products.isEmpty
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemCount: cubit.filteredProducts.isEmpty
                      ? products.length
                      : cubit.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = cubit.filteredProducts.isEmpty
                        ? products[index]
                        : cubit.filteredProducts[index];

                    return ItemWidget(
                        productId: product.id!,
                        onPressed: () {
                          cubit.addOrDelateFromCart(
                              productId: product.id.toString());
                        },
                        inCart: cubit.cartId.contains(product.id.toString()),
                        isFavorite:
                            cubit.productsId.contains(product.id.toString()),
                        onTap: () {
                          cubit.addOrDelateFavProduct(
                              productId: product.id.toString());
                        },
                        image: product.images?.isNotEmpty == true
                            ? product.images!.first
                            : 'https://via.placeholder.com/150',
                        title: product.name ?? "No Name",
                        price: "${product.price}\$",
                        oldPrice: product.price == product.oldPrice
                            ? ""
                            : "${product.oldPrice ?? 0} \$");
                  },
                );
        });
      },
    );
  }
}
