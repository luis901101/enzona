
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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

  bool isLoading = true;
  WebViewXController? webViewXController;
  InAppWebViewController? inAppWebViewControllerController;

  String get confirmationUrl => widget.payment.confirmationUrl ?? 'about:blank';
  String get returnUrl => widget.payment.returnUrl ?? 'about:blank';
  String get cancelUrl => widget.payment.cancelUrl ?? 'about:blank';

  Widget get webView {
    // if(kIsWeb || Platform.isIOS) {
    //   return WebViewX(
    //     width: double.infinity,
    //     height: double.infinity,
    //     initialContent: confirmationUrl,
    //     initialSourceType: SourceType.url,
    //     javascriptMode: JavascriptMode.unrestricted,
    //     // gestureNavigationEnabled: true,
    //     onWebViewCreated: (controller) {
    //       webViewXController = controller;
    //     },
    //     navigationDelegate: (request) async =>
    //       onNavigateTo(request.content.source) ?
    //         NavigationDecision.navigate :
    //           NavigationDecision.prevent,
    //     onPageFinished: (url) => hideLoading(),
    //   );
    // }
    return InAppWebView(
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
        ),
      ),
      initialUrlRequest: URLRequest(url: Uri.parse(confirmationUrl)),
      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
      },
      onWebViewCreated: (controller) {
        inAppWebViewControllerController = controller;
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        final url = navigationAction.request.url?.toString() ?? '';
        return onNavigateTo(url) ?
          NavigationActionPolicy.ALLOW :
          NavigationActionPolicy.CANCEL;
      },
      onLoadStart: (controller, url) async => showLoading(),
      onLoadStop: (controller, url) async => hideLoading(),
      onLoadError: (controller, url, code, message) => hideLoading(),
    );
  }

  void showLoading() {
    if(!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
  }

  void hideLoading() {
    if(isLoading) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onConfirmed() {
    widget.onPaymentConfirmed(
      widget.payment
        ..statusCode = StatusCode.confirmada
        ..statusDenom = 'Confirmada'
        ..updatedAt = DateTime.now(),
    );
  }

  void onCancelled() {
    widget.onPaymentCancelled(widget.payment); //No Payment modification gets done
  }

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
              onPressed: () => controllerGoBack(),
            ),
            iconButton(
              iconData: Icons.refresh,
              onPressed: () => controllerReload(),
            ),
            iconButton(
              iconData: Icons.arrow_forward,
              onPressed: () => controllerGoForward(),
            ),
          ],
        ),
      ),
    );
  }

  bool onNavigateTo(String url) {
    showLoading();
    if (url.startsWith(returnUrl)) {
      onConfirmed();
      return false;
    }
    if(url.startsWith(cancelUrl)) {
      onCancelled();
      return false;
    }
    return true;
  }

  Future<void> controllerReload() async {
    webViewXController?.reload();
    inAppWebViewControllerController?.reload();
  }

  Future<void> controllerGoForward() async {
    webViewXController?.goForward();
    inAppWebViewControllerController?.goForward();
  }

  Future<void> controllerGoBack() async {
    webViewXController?.goBack();
    inAppWebViewControllerController?.goBack();
  }
}
