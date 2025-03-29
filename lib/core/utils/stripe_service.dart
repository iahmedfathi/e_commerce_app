
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/core/api/api_consumer.dart';
import 'package:shop_app/core/api/end_pointes.dart';
import 'package:shop_app/core/errors/error_model.dart';
import 'package:shop_app/core/errors/exceptions.dart';
import 'package:shop_app/features/checkout/data/models/payment_intent_input.dart';
import 'package:shop_app/features/checkout/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  final ApiConsumer apiConsumer;

  StripeService({required this.apiConsumer});

  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentInputModel) async {
    final response = await apiConsumer.post(EndPoint.paymentIntents,
        data: paymentInputModel.toJson(),);
    final paymentIntentModel = PaymentIntentModel.fromJson(response);
    return paymentIntentModel;
  }

  Future<void> initPaymentSheet(
      {required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: 'App Store',
        paymentIntentClientSecret: paymentIntentClientSecret,
      ),
    );
  }

  Future<void> diPlayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

Future<void> makePaymentSheet({required PaymentIntentInputModel paymentInputModel}) async {
  try {
    var paymentIntentInputModel = await createPaymentIntent(paymentInputModel);
    await initPaymentSheet(
        paymentIntentClientSecret: paymentIntentInputModel.clientSecret!);
    await diPlayPaymentSheet();
  } on StripeException catch (e) {
    if (e.error.code == FailureCode.Canceled) {
      throw ServerException(errModel: ErrorModel(errorMessage: "Payment was canceled by the user."));
    } else {
      throw ServerException(errModel: ErrorModel(errorMessage: e.error.localizedMessage ?? "Payment failed."));
    }
  } catch (e) {
    throw ServerException(errModel: ErrorModel(errorMessage: "An unexpected error occurred: $e"));
  }
}


  // Future<PaymentIntentModel> createCustomers(
  //     CustomersModel customersModel) async {
  //   final response = await apiConsumer.post(EndPoint.customers,
  //       data: customersModel.toJson());
  //   final paymentIntentModel = PaymentIntentModel.fromJson(response);
  //   return paymentIntentModel;
  // }
}
