

import 'package:enzona_flutter/enzona_flutter.dart';
import 'package:example/src/page/payment_confirmation_full_screen_page_v1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentConfirmationFullScreenPageV2 extends StatefulWidget {
  const PaymentConfirmationFullScreenPageV2({Key? key}) : super(key: key);

  @override
  State createState() => PaymentConfirmationFullScreenPageV2State();
}

class PaymentConfirmationFullScreenPageV2State extends PaymentConfirmationFullScreenPageV1State {

  @override
  Future<void> launchPaymentConfirmationScreen() async {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
        PaymentConfirmationScreen(
          payment: payment!,
          onPaymentConfirmed: onPaymentChanged,
          onPaymentCancelled: onPaymentChanged,
        )));
  }

  void onPaymentChanged(Payment payment) {
    setState(() {
      this.payment = payment;
      if(payment.statusCode != StatusCode.confirmada) {
        paymentCancelled = true;
      }
    });
  }
}