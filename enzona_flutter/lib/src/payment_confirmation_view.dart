
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webviewx/webviewx.dart';
import 'package:enzona/enzona.dart';

class PaymentConfirmationView extends StatefulWidget {

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

  @override
  PaymentConfirmationViewState createState() => PaymentConfirmationViewState();
}

class PaymentConfirmationViewState extends State<PaymentConfirmationView> {

  bool isLoading = false;
  WebViewXController? controller;

  String get confirmationUrl => widget.payment.confirmationUrl ?? 'about:blank';
  String get returnUrl => widget.payment.returnUrl ?? 'about:blank';
  String get cancelUrl => widget.payment.cancelUrl ?? 'about:blank';

  Widget get webView => WebViewX(
    width: double.infinity,
    height: double.infinity,
    initialContent: confirmationUrl,
    initialSourceType: SourceType.url,
    javascriptMode: JavascriptMode.unrestricted,
    // gestureNavigationEnabled: true,
    onWebViewCreated: (controller) {
      this.controller = controller;
    },
    navigationDelegate: (request) async {
      if(!isLoading) {
        setState(() {
          isLoading = true;
        });
      }
      String url = request.content.source;
      if (url.startsWith(returnUrl)) {
        widget.onPaymentConfirmed(
          widget.payment
            ..statusCode = StatusCode.confirmada
            ..statusDenom = 'Confirmada'
            ..updatedAt = DateTime.now(),
        );
        return NavigationDecision.prevent;
      }
      if(url.startsWith(cancelUrl)) {
        widget.onPaymentCancelled(widget.payment); //No Payment modification gets done
        return NavigationDecision.prevent;
      }
      return NavigationDecision.navigate;
    },
    onPageFinished: (url) {
      if(isLoading) {
        setState(() {
          isLoading = false;
        });
      }
    },
  );

  Widget iconButton({
    required IconData iconData,
    required VoidCallback onPressed,
  }) => IconButton(
    iconSize: 30,
    icon: Icon(iconData),
    color: Theme.of(context).colorScheme.secondary,
    onPressed: isLoading ? null : onPressed,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          webView,
          AnimatedPositioned(
            left: 0,
            right: 0,
            top: 0,
            height: isLoading ? 5 : 0,
            duration: const Duration(milliseconds: 200),
            child: const LinearProgressIndicator(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 8,
        color: Theme.of(context).bottomAppBarColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            iconButton(
              iconData: Icons.arrow_back,
              onPressed: () => controller?.goBack(),
            ),
            iconButton(
              iconData: Icons.refresh,
              onPressed: () => controller?.reload(),
            ),
            iconButton(
              iconData: Icons.arrow_forward,
              onPressed: () => controller?.goForward(),
            ),
          ],
        ),
      ),
    );
  }
}
