

import 'package:enzona_flutter/enzona_flutter.dart';
import 'package:example/src/page/base_page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentConfirmationFullScreenPage extends StatefulWidget {
  const PaymentConfirmationFullScreenPage({Key? key}) : super(key: key);

  @override
  State<PaymentConfirmationFullScreenPage> createState() => PaymentConfirmationFullScreenPageState();
}

class PaymentConfirmationFullScreenPageState extends BasePageState<PaymentConfirmationFullScreenPage> {

  @override
  Widget paymentConfirmationCustomView() {

    return Column(
      children: [
        if(payment?.statusCode != StatusCode.confirmada)
        ElevatedButton(
          child: const Text('Confirmar pago ahora'),
          onPressed: confirmPayment,
        ),
      ],
    );
  }

  Future<void> confirmPayment() async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
            PaymentConfirmationScreen(payment: payment!)));

    if(result is Payment) {
      setState(() {
        payment = result;
        if(payment?.statusCode != StatusCode.confirmada) {
          paymentCancelled = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de Confirmación de pago'),
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
                    'Este es un ejemplo de como usar la pantalla de confirmación de pago.',
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