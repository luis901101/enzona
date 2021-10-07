

import 'package:enzona_flutter/enzona_flutter.dart';
import 'package:example/src/page/base_page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentConfirmationFullScreenPageV1 extends StatefulWidget {
  const PaymentConfirmationFullScreenPageV1({Key? key}) : super(key: key);

  @override
  State createState() => PaymentConfirmationFullScreenPageV1State<PaymentConfirmationFullScreenPageV1>();
}

class PaymentConfirmationFullScreenPageV1State<S extends StatefulWidget> extends BasePageState<S> {

  @override
  Widget paymentConfirmationCustomView() {
    return payment?.statusCode != StatusCode.confirmada ?
      ElevatedButton(
        child: const Text('Confirmar pago ahora'),
        onPressed: launchPaymentConfirmationScreen,
      ) : const SizedBox();
  }

  Future<void> launchPaymentConfirmationScreen() async {
    final result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
        PaymentConfirmationScreen(
          title: 'Confirmar pago variante 1',
          payment: payment!,
        )
      ));
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