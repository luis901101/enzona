
import 'package:enzona_flutter/enzona_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentConfirmationExternalLink extends StatefulWidget {
  final String title;
  final Enzona enzona;
  final Payment payment;

  /// This function will be called when client confirms the payment.
  /// It will receive the updated Payment.
  /// It's not required because Payment will be returned when screen pops
  final ValueChanged<Payment>? onPaymentConfirmed;

  /// This function will be called when client cancels the payment.
  /// It will receive the updated Payment
  /// It's not required because Payment will be returned when screen pops
  final ValueChanged<Payment>? onPaymentCancelled;

  final ThemeData? themeData;

  final Function({Object? error, Exception? exception})? onError;

  final bool tryUniversalLinks;

  const PaymentConfirmationExternalLink({
    Key? key,
    this.title = 'Confirmar pago',
    required this.enzona,
    required this.payment,
    this.onPaymentConfirmed,
    this.onPaymentCancelled,
    this.themeData,
    this.onError,
    this.tryUniversalLinks = true,
  }) : super(key: key);

  @override
  State createState() => PaymentConfirmationExternalLinkState();
}

class PaymentConfirmationExternalLinkState extends State<PaymentConfirmationExternalLink> with WidgetsBindingObserver {

  AppLifecycleState? lifecycleState;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      onCreated();
    });
  }

  void onCreated() {
    launchExternalConfirm();
  }

  Future<bool> launchExternalConfirm() async {
    String url = widget.payment.confirmationUrl ?? '';
    try {
      String suitableURL;
      if (!url.startsWith("http://") &&
          !url.startsWith("https://") &&
          !url.startsWith("ftp://") &&
          !url.startsWith("file://")) {
        suitableURL = "http://$url";
      } else {
        suitableURL = url;
      }

      final bool nativeAppLaunchSucceeded = !widget.tryUniversalLinks ? false :
        await launch(
          suitableURL,
          forceSafariVC: false,
          enableJavaScript: true,
          universalLinksOnly: widget.tryUniversalLinks,
        );

      if (nativeAppLaunchSucceeded) return true;

      return await launch(
        suitableURL,
        forceSafariVC: true,
        enableJavaScript: true,
      );
    } catch (e) {
      e.toString();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Theme(
          data: widget.themeData ?? ThemeData.fallback(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              leading: CloseButton(
                onPressed: () {
                  onCancelled(widget.payment);
                },
              ),
            ),
            body: WillPopScope(
              onWillPop: onBackPressed,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }

  void onConfirmed(Payment payment, ) {
    Navigator.pop(context, payment);
    widget.onPaymentConfirmed?.call(payment);
  }

  void onCancelled(Payment payment, ) {
    Navigator.pop(context, payment);
    widget.onPaymentCancelled?.call(payment);
  }

  void onError({Object? error, Exception? exception}) {
    Navigator.pop(context, error ?? exception);
    widget.onError?.call(error: error, exception: exception);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    lifecycleState = state;
    switch (state) {
      case AppLifecycleState.resumed:
        onResumedFromExternalApp();
        break;
      default:
        break;
    }
  }
  
  Future<void> onResumedFromExternalApp() async {
    EResponse<Payment>? response;
    try {
      response = await widget.enzona.paymentAPI.getPayment(transactionUUID: widget.payment.transactionUUID ?? '');
      if(response.isSuccessful && response.body != null) {
        final payment = response.body!;
        if(payment.statusCode == StatusCode.confirmada) {
          onConfirmed(payment);
        } else {
          onCancelled(payment);
        }
        return;
      }
      onError(error: response.error);
    } catch (e) {
      if(e is Exception) {
        onError(exception: e);
      } else {
        onError(error: e);
      }
    }

  }

  Future<bool> onBackPressed() async {
    return false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}