

import 'package:enzona_flutter/enzona_flutter.dart';
import 'package:example/src/page/base_page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentConfirmationExternalLinkPageV1 extends StatefulWidget {
  const PaymentConfirmationExternalLinkPageV1({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => PaymentConfirmationExternalLinkPageV1State<PaymentConfirmationExternalLinkPageV1>();
}

class PaymentConfirmationExternalLinkPageV1State<S extends PaymentConfirmationExternalLinkPageV1> extends BasePageState<S> {

  @override
  String get description => 'Este es un ejemplo de cómo confirmar un pago usando el navegador del Sistema (Variante 1).';

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
        PaymentConfirmationExternalLink(
          title: 'Confirmar pago en app externa Variante 1',
          enzona: enzona,
          payment: payment!,
          tryUniversalLinks: true,
          themeData: ThemeData.light().copyWith(
            colorScheme: ThemeData.light().colorScheme.copyWith(
              primary: Colors.orange,
            )
          ),
        )
      ));
    if(result is Payment) {
      setState(() {
        payment = result;
        if(payment?.statusCode != StatusCode.confirmada) {
          paymentCancelled = true;
        }
      });
    } else {
      // If code reach here an error occurred
      onError(
        error: result is ErrorResponse ? result : null,
        exception: result is Exception ? result : null,
      );
    }
  }

  void onError({Object? error, Exception? exception}) {
    errorMessage = 'Error desconocido';
    if(error is ErrorResponse && error.message != null) {
      errorMessage = '${error.message}';
    } else
    if(exception != null) {
      errorMessage = exception.toString();
    }
    setState(() {});
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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