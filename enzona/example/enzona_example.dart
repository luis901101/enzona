import 'dart:io';

import 'package:enzona/enzona.dart';
import 'package:enzona/src/enumerator/order.dart';

/// Make sure to set all of this environment variables before running tests
///
/// export ENZONA_API_URL=https://apisandbox.enzona.net
/// export ENZONA_ACCESS_TOKEN_URL=https://apisandbox.enzona.net/token
/// export ENZONA_CONSUMER_KEY=your_consumer_key
/// export ENZONA_CONSUMER_SECRET=your_consumer_secret
/// export ENZONA_SCOPES=am_application_scope,enzona_business_payment,enzona_business_qr
///
final String? apiUrl = Platform.environment['ENZONA_API_URL'];
final String? accessTokenUrl = Platform.environment['ENZONA_ACCESS_TOKEN_URL'];
final String? consumerKey = Platform.environment['ENZONA_CONSUMER_KEY'];
final String? consumerSecret = Platform.environment['ENZONA_CONSUMER_SECRET'];
List<String>? scopes = Platform.environment['ENZONA_SCOPES']?.split(',');

const String transactionUUID = '2796bfba66be4ba6b9fb5d4b0d011d0d';

late Enzona enzona;

Future<void> main() async {
  ///Creating enzona SDK instance
  enzona = Enzona(
    apiUrl: apiUrl!,
    accessTokenUrl: accessTokenUrl,
    consumerKey: consumerKey!,
    consumerSecret: consumerSecret!,
    scopes: scopes!,
    timeout: Duration(seconds: 30),
  );

  ///Initializing
  await enzona.init();

}

/// Getting payments list
Future<void> paymentsList() async {
  final response = await enzona.paymentAPI.getPayments(
    pageIndex: 0,
    pageSize: 5,
    enzonaOp: 'test',
    merchantOp: 'test',
    merchantUUID: 'test',
    status: StatusCode.confirmada,
    startDate: DateTime.now().subtract(Duration(days: 7)),
    endDate: DateTime.now(),
    order: Order.desc,
  );
  if(response.isSuccessful && (response.body?.isNotEmpty ?? false)) {
    print('totalCount: ${response.headers[Pagination.totalCountHeader]}');
    for(var payment in response.body!) {
      print('id: ${payment.transactionUUID}, statusCode: ${payment.statusCode}');
    }
  }
}

/// Getting payment by id
Future<void> paymentById() async {
  final response = await enzona.paymentAPI.getPayment(transactionUUID: transactionUUID);
  if(response.isSuccessful) {
    final payment = response.body;
    print('id: ${payment?.transactionUUID}, statusCode: ${payment?.statusCode}');
  }
}

/// Create payment
Future<void> createPayment() async {
  final payment = PaymentRequest(
    returnUrl: "http://url.to.return.after.payment.confirmation",
    cancelUrl: "http://url.to.return.after.payment.cancellation",
    merchantOpId: PaymentRequest.generateRandomMerchantOpId(),
    currency: "CUP",
    amount: PaymentAmount(
      total: 33,
      details: PaymentAmountDetails(
        shipping: 1,
        tax: 0,
        discount: 2,
        tip: 4,
      ),
    ),
    items: [
      PaymentItem(
        name: "Payment Item 1",
        description: "Some item description",
        quantity: 2,
        price: 15,
        tax: 0,
      )
    ],
    description: "This is an example payment description",
  );

  final response = await enzona.paymentAPI.createPayment(data: payment);
  if(response.isSuccessful) {
    final createdPayment = response.body;
    print('id: ${createdPayment?.transactionUUID}, statusCode: ${createdPayment?.statusCode}');

    String? confirmationUrl = payment.confirmationUrl;
    launch(confirmationUrl);

  }
}

void launch(String? url) {
  /// Launching url to web browser is not managed by this library
}

/// Complete payment
Future<void> completePayment() async {
  final response = await enzona.paymentAPI.completePayment(transactionUUID: transactionUUID);

  if(response.isSuccessful) {
    final completedPayment = response.body;
    print('id: ${completedPayment?.transactionUUID}, statusCode: ${completedPayment?.statusCode}');
  } else if(response.error is ErrorResponse &&
      (response.error as ErrorResponse).code == StatusCode.transaccionNoConfirmada) {
    final errorResponse = response.error as ErrorResponse;
    print('Mensaje de error: ${errorResponse.message}. El pago debe confirmarse antes de proceder completarse');
  }
}

/// Cancel payment
Future<void> cancelPayment() async {
  final response = await enzona.paymentAPI.cancelPayment(transactionUUID: transactionUUID);

  if(response.isSuccessful) {
    final cancelledPayment = response.body;
    print('id: ${cancelledPayment?.transactionUUID}, statusCode: ${cancelledPayment?.statusCode}');
  } else  {
    print('Hubo un error y no se pudo cancelar el pago.');
  }
}

/// Get refunds list
Future<void> refundsList() async {
  final response = await enzona.paymentAPI.getRefunds(
    pageIndex: 0,
    pageSize: 5,
    merchantUUID: 'test',
    commerceRefundId: 'test',
    transactionUUID: transactionUUID,
    status: StatusCode.aceptada,
    startDate: DateTime.now().subtract(Duration(days: 7)),
    endDate: DateTime.now(),
    order: Order.desc,
  );
  if(response.isSuccessful && (response.body?.isNotEmpty ?? false)) {
    print('totalCount: ${response.headers[Pagination.totalCountHeader]}');
    for(var refund in response.body!) {
      print('id: ${refund.transactionUUID}, statusCode: ${refund.statusCode}');
    }
  }
}

/// Get refund by id
Future<void> refundById() async {
  final response = await enzona.paymentAPI.getRefund(transactionUUID: transactionUUID);
  if(response.isSuccessful) {
    final refund = response.body;
    print('id: ${refund?.transactionUUID}, statusCode: ${refund?.statusCode}');
  }
}

/// Full refund
Future<void> fullRefund() async {
  final response = await enzona.paymentAPI.refundPayment(transactionUUID: transactionUUID);
  if(response.isSuccessful) {
    final refund = response.body;
    print('id: ${refund?.transactionUUID}, statusCode: ${refund?.statusCode}');
  }
}

/// Partial refund
Future<void> partialRefund() async {
  final refund = Refund(
      amount: PaymentAmount(
        total: 5,
      ),
      description: 'This is a partial refund'
  );
  final response = await enzona.paymentAPI.refundPayment(transactionUUID: transactionUUID, data: refund);

  if(response.isSuccessful) {
    final refund = response.body;
    print('id: ${refund?.transactionUUID}, statusCode: ${refund?.statusCode}');
  }
}
