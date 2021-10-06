
import 'package:flutter/widgets.dart';
import 'package:webviewx/webviewx.dart';
import 'package:enzona/enzona.dart';

class PaymentConfirmationView extends StatelessWidget {

  final Payment payment;
  final VoidCallback onPaymentConfirmed;
  final VoidCallback onPaymentCancelled;

  const PaymentConfirmationView({
    Key? key,
    required this.payment,
    required this.onPaymentConfirmed,
    required this.onPaymentCancelled,
  }) : super(key: key);

  String get confirmationUrl => payment.confirmationUrl ?? 'about:blank';
  String get returnUrl => payment.returnUrl ?? 'about:blank';
  String get cancelUrl => payment.cancelUrl ?? 'about:blank';

  @override
  Widget build(BuildContext context) {
    return WebViewX(
      width: double.infinity,
      height: double.infinity,
      initialContent: confirmationUrl,
      initialSourceType: SourceType.url,
      onPageStarted: (url) {
        if(url.startsWith(returnUrl)) return onPaymentConfirmed();
        if(url.startsWith(cancelUrl)) return onPaymentCancelled();
      },
    );
  }
}
