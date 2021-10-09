

import 'package:enzona_flutter/enzona_flutter.dart';
import 'package:example/src/page/payment_confirmation_external_link_page_v1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentConfirmationExternalLinkPageV2 extends PaymentConfirmationExternalLinkPageV1 {
  const PaymentConfirmationExternalLinkPageV2({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => PaymentConfirmationExternalLinkPageV2State<PaymentConfirmationExternalLinkPageV2>();
}

class PaymentConfirmationExternalLinkPageV2State<S extends PaymentConfirmationExternalLinkPageV1> extends PaymentConfirmationExternalLinkPageV1State<S> {

  @override
  String get description => 'Este es un ejemplo de cómo confirmar un pago usando el navegador del Sistema (Variante 2).';

  @override
  Widget paymentConfirmationCustomView() {
    return payment?.statusCode != StatusCode.confirmada ?
      ElevatedButton(
        child: const Text('Confirmar pago ahora'),
        onPressed: launchPaymentConfirmationScreen,
      ) : const SizedBox();
  }

  @override
  Future<void> launchPaymentConfirmationScreen() async {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
        PaymentConfirmationExternalLink(
          title: 'Confirmar pago en app externa Variante 2',
          enzona: enzona,
          payment: payment!,
          onPaymentConfirmed: onPaymentChanged,
          onPaymentCancelled: onPaymentChanged,
          tryUniversalLinks: true,
          onError: onError,
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