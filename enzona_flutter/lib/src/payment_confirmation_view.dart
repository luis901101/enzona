
import 'package:flutter/widgets.dart';
import 'package:webviewx/webviewx.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:enzona/enzona.dart';

class PaymentConfirmationView extends StatelessWidget {

  final Payment payment;

  /// This function will be called when client confirms the payment.
  /// It will receive the updated Payment
  final ValueChanged<Payment> onPaymentConfirmed;

  /// This function will be called when client cancels the payment.
  /// It will receive the updated Payment
  final ValueChanged<Payment> onPaymentCancelled;

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
      javascriptMode: JavascriptMode.unrestricted,
      // gestureNavigationEnabled: true,
      navigationDelegate: (request) async {
        String url = request.content.source;
        if (url.startsWith(returnUrl)) {
          onPaymentConfirmed(
            payment
              ..statusCode = StatusCode.confirmada
              ..statusDenom = 'Confirmada'
              ..updatedAt = DateTime.now(),
          );
          return NavigationDecision.prevent;
        }
        if(url.startsWith(cancelUrl)) {
          onPaymentCancelled(payment); //No Payment modification gets done
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }
}
