
import 'dart:math';

import 'package:chopper/chopper.dart';
import 'package:enzona_flutter/enzona_flutter.dart';
import 'package:example/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

abstract class BasePageState<S extends StatefulWidget> extends State<S> {
  bool isLoading = true;
  bool paymentCancelled = false;
  Payment? payment;
  late PaymentRequest paymentRequest;
  Response<Payment>? response;
  late Enzona enzona;
  String ? errorMessage;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      enzona = Enzona(
          apiUrl: apiUrl,
          accessTokenUrl: accessTokenUrl,
          consumerKey: consumerKey,
          consumerSecret: consumerSecret,
          scopes: scopes
      );
      paymentRequest = PaymentRequest(
        returnUrl: "http://url.to.return.after.payment.confirmation",
        cancelUrl: "http://url.to.return.after.payment.cancellation",
        merchantOpId: PaymentRequest.generateRandomMerchantOpId(),
        currency: "CUP",
        amount: PaymentAmount(
          total: Random().nextInt(50) + 50,
          details: PaymentAmountDetails(
            shipping: 0,
            tax: 0,
            discount: 0,
            tip: 0,
          ),
        ),
        description: "This is an example payment description",
      );

      await enzona.init();

      await createPayment();
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> createPayment() async {
    if(!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    try {
      errorMessage = null;
      paymentCancelled = false;
      if(!enzona.isInitialized) {
        errorMessage = 'Enzona debe inicializarse antes de usarse.';
        return;
      }
      response = await enzona.paymentAPI.createPayment(data: paymentRequest);
      if(response?.isSuccessful ?? false) {
        payment = response?.body;
      } else {
        errorMessage = response?.error is ErrorResponse ? (response?.error as ErrorResponse).message : null;
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget get paymentConfirmationManagementView {

    if(isLoading) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            Text('Creando el pago, espere un momento por favor.'),
            SizedBox(height: 8),
            CircularProgressIndicator(),
          ],
        ),
      );
    }

    if(!(response?.isSuccessful ?? false) || payment == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '''
              HUBO UN PROBLEMA AL INTENTAR CREAR EL PAGO.
              Verifique que está recibiendo correctamente el consumerKey y el consumerSecret desde String.fromEnvironment
              ${errorMessage ?? ''} 
              ''',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              child: const Text('Reintentar'),
              onPressed: createPayment,
            ),
          ],
        ),
      );
    }

    if(payment?.statusCode != StatusCode.pendiente) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'EL PAGO FUE CONFIRMADO SATISFACTORIAMENTE POR EL CLIENTE.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      );
    }

    if(paymentCancelled) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'EL PAGO FUE CANCELADO POR EL CLIENTE.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              child: const Text('Crear otro pago'),
              onPressed: createPayment,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color),
            children: [
              TextSpan(text: '${payment?.amount?.total?.toStringAsFixed(2)} ', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
              TextSpan(text: '${payment?.currency}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.normal),),
            ]
          ),
        ),
        const SizedBox(height: 8),
          Text('${payment?.description} ', style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),),
        const SizedBox(height: 8),
        paymentConfirmationCustomView(),
      ],
    );
  }

  Widget paymentConfirmationCustomView();
}