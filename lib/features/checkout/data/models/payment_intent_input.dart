class PaymentIntentInputModel {
  final String currency;
  final String? customerId;
  final int amount;

  PaymentIntentInputModel({
    this.customerId,
    required this.currency,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'amount': amount * 100,
      'customer': customerId,
    };
  }
}
