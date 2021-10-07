

import 'package:enzona_flutter/enzona_flutter.dart';
import 'package:example/src/page/base_page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentConfirmationEmbedPage extends StatefulWidget {
  const PaymentConfirmationEmbedPage({Key? key}) : super(key: key);

  @override
  State createState() => _PaymentConfirmationEmbedPageState();
}

class _PaymentConfirmationEmbedPageState extends BasePageState<PaymentConfirmationEmbedPage> {

  @override
  Widget paymentConfirmationCustomView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 70 / 100,
      child: PaymentConfirmationView(
        payment: payment!,
        onPaymentConfirmed: (payment) {
          setState(() {
            this.payment = payment;
          });
        },
        onPaymentCancelled: (payment) {
          setState(() {
            paymentCancelled = true;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmación de pago embebida'),
      ),
      body: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(
                  size: 100,
                  style: FlutterLogoStyle.stacked,
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Este es un ejemplo de como usar el Widget de confirmación de pago embebido en un WidgetTree',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                paymentConfirmationManagementView,
              ],
            ),
          ),
        ),
      ),
    );
  }
}