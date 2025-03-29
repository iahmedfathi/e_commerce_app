import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/api/dio_consumer.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/core/utils/stripe_service.dart';
import 'package:shop_app/features/checkout/data/repos/checkout_repo_impl.dart';
import 'package:shop_app/features/checkout/presentation/controllers/payment_cubit.dart';
import 'package:shop_app/features/checkout/presentation/widgets/custom_button.dart';
import 'package:shop_app/features/checkout/presentation/widgets/payment_methods_bottom_sheet.dart';
import 'package:shop_app/features/layout/presentation/controllers/cubit/layout_cubit.dart';
import 'package:shop_app/features/layout/presentation/views/screens/product_details_screen.dart';
import 'package:shop_app/features/layout/presentation/views/widgets/price_widget.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = LayoutCubit.get(context);
        final carts = cubit.cartProducts;

        if (carts.isEmpty) {
          return Center(
            child: Text(
              'No products yet',
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
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: carts.length,
                  itemBuilder: (context, index) {
                    final product = carts[index];
                    return Container(
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
                                      productId: product.id),
                                ),
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: product.image!,
                              fit: BoxFit.fill,
                              height: 120,
                              width: 100,
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
                                  product.name ?? "No Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColors.mainColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                PriceWidget(
                                  price: "${product.price ?? 0} \$",
                                  oldPrice: product.price == product.oldPrice
                                      ? ""
                                      : "${product.oldPrice ?? 0} \$",
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: cubit.productsId
                                                .contains(product.id.toString())
                                            ? Colors.red
                                            : AppColors.mainColor,
                                      ),
                                      onPressed: () {
                                        cubit.addOrDelateFavProduct(
                                            productId: product.id.toString());
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: AppColors.mainColor,
                                      ),
                                      onPressed: () {
                                        cubit.addOrDelateFromCart(
                                            productId: product.id.toString());
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Divider(
                height: 30,
                color: AppColors.mainColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'total price ',
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter'),
                  ),
                  Text(
                    " ${cubit.totalPrice}\$",
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter'),
                  ),
                ],
              ),
              CustomButton(
                text: 'Complete Payment',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => BlocProvider(
                      create: (context) => PaymentCubit(
                        CheckoutRepoImpl(
                          stripeService: StripeService(
                            apiConsumer: DioConsumer(dio: Dio()),
                          ),
                        ),
                      ),
                      child: PaymentMethodsBottomSheet(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
