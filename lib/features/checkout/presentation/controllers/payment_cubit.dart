import 'dart:developer';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/checkout/data/models/payment_intent_input.dart';
import 'package:shop_app/features/checkout/data/repos/checkout_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());

  static PaymentCubit get(context) => BlocProvider.of<PaymentCubit>(context);

  final CheckoutRepo checkoutRepo;

  Future<void> makePayment({required PaymentIntentInputModel paymentInputModel}) async {
    emit(PaymentLoading());

    final result = await checkoutRepo.makePayMent(paymentInputModel: paymentInputModel);

    result.fold(
      (error) {
        if (error.contains("canceled")) {
          emit(PaymentFailure(errorMessage: "User canceled the payment."));
        } else {
          emit(PaymentFailure(errorMessage: error));
        }
      },
      (_) => emit(PaymentSuccess()),
    );
  } @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}

