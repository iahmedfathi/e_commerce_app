import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CustomCreditCard extends StatefulWidget {
  const CustomCreditCard(
      {super.key, required this.formKey, this.autovalidateMode});
  final GlobalKey<FormState> formKey;
  final AutovalidateMode? autovalidateMode;

  @override
  State<CustomCreditCard> createState() => _CustomCreditCardState();
}

class _CustomCreditCardState extends State<CustomCreditCard> {
  String cardNumber = "";
  String expiryDate = "";
  String cardHolderName = "";
  String cvvCode = "";
  bool showBackView = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCardWidget(
            isHolderNameVisible: true,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: showBackView,
            onCreditCardWidgetChange: (value) {}),
        CreditCardForm(
            autovalidateMode: widget.autovalidateMode,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            onCreditCardModelChange: (creditCardBrand) {
              cardHolderName = creditCardBrand.cardHolderName;
              cardNumber = creditCardBrand.cardNumber;
              expiryDate = creditCardBrand.expiryDate;
              cvvCode = creditCardBrand.cvvCode;
              showBackView = creditCardBrand.isCvvFocused;
              setState(() {});
            },
            formKey: widget.formKey),
      ],
    );
  }
}
