
import 'package:enzona_flutter/enzona_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final String title;
  final Payment payment;

  /// This function will be called when client confirms the payment.
  /// It will receive the updated Payment.
  /// It's not required because Payment will be returned when screen pops
  final ValueChanged<Payment>? onPaymentConfirmed;

  /// This function will be called when client cancels the payment.
  /// It will receive the updated Payment
  /// It's not required because Payment will be returned when screen pops
  final ValueChanged<Payment>? onPaymentCancelled;

  late final BuildContext context;
  final paymentViewStateKey = GlobalKey<PaymentConfirmationViewState>();

  PaymentConfirmationScreen({
    Key? key,
    this.title = 'Confirmar pago',
    required this.payment,
    this.onPaymentConfirmed,
    this.onPaymentCancelled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: CloseButton(
          onPressed: () {
            onCancelled(payment);
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: onBackPressed,
        child: PaymentConfirmationView(
          key: paymentViewStateKey,
          payment: payment,
          onPaymentConfirmed: onConfirmed,
          onPaymentCancelled: onCancelled,
        ),
      ),
    );
  }

  void onConfirmed(Payment payment, ) {
    Navigator.pop(context, payment);
    onPaymentConfirmed?.call(payment);
  }

  void onCancelled(Payment payment, ) {
    Navigator.pop(context, payment);
    onPaymentCancelled?.call(payment);
  }

  Future<bool> onBackPressed() async {
    if(!((await paymentViewStateKey.currentState?.onBackPressed()) ?? false)) {
      return false;
    }
    onCancelled(payment);
    return false;
  }

}
