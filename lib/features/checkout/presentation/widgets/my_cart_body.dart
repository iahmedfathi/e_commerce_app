
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/api/dio_consumer.dart';
import 'package:shop_app/core/utils/stripe_service.dart';
import 'package:shop_app/features/checkout/data/repos/checkout_repo_impl.dart';
import 'package:shop_app/features/checkout/presentation/controllers/payment_cubit.dart';
import 'package:shop_app/features/checkout/presentation/widgets/custom_button.dart';
import 'package:shop_app/features/checkout/presentation/widgets/order_price.dart';
import 'package:shop_app/features/checkout/presentation/widgets/payment_methods_bottom_sheet.dart';
import 'package:shop_app/features/checkout/presentation/widgets/total_price.dart';

class MyCartBody extends StatelessWidget {
  const MyCartBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 18,
          ),
          Expanded(child: Image.asset("assets/images/Group 7.png")),
          SizedBox(
            height: 25,
          ),
          OrderPrice(title: 'Order Subtotal', price: r'$42.97'),
          OrderPrice(title: 'Discount', price: r'$0'),
          OrderPrice(title: 'Shipping', price: r'$8'),
          Divider(
            height: 34,
            color: Color(0xffC7C7C7),
            indent: 15,
            endIndent: 15,
          ),
          TotalPrice(
            title: 'Total',
            price: r'$50.97',
          ),
          SizedBox(
            height: 16,
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
          SizedBox(
            height: 25,
          ),
          SizedBox()
        ],
      ),
    );
  }
}
