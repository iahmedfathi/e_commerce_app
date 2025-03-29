
import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/exceptions.dart';
import 'package:shop_app/core/utils/stripe_service.dart';
import 'package:shop_app/features/checkout/data/models/payment_intent_input.dart';
import 'package:shop_app/features/checkout/data/repos/checkout_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService stripeService;

  CheckoutRepoImpl({required this.stripeService});
  @override
  Future<Either<String, void>> makePayMent(
      {required PaymentIntentInputModel paymentInputModel}) async {
    try {
      await stripeService.makePaymentSheet(
          paymentInputModel: paymentInputModel);
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage); // ✅ Return correct error message
    } catch (e) {
      return Left("An unexpected error occurred: $e"); // ✅ Catch all other exceptions
    }
  }
}
