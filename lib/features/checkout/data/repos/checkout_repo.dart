
import 'package:dartz/dartz.dart';
import 'package:shop_app/features/checkout/data/models/payment_intent_input.dart';

abstract class CheckoutRepo {
  Future<Either<String, void>> makePayMent(
      {required PaymentIntentInputModel paymentInputModel});
}
