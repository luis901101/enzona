import 'package:chopper/chopper.dart';
import 'package:enzona/src/base_api/enzona_response.dart';
import 'package:enzona/src/entity/error_response.dart';
import 'package:enzona/src/entity/pagination.dart';
import 'package:enzona/src/entity/payment_amount.dart';
import 'package:enzona/src/entity/payment_amount_details.dart';
import 'package:enzona/src/entity/payment_item.dart';
import 'package:enzona/src/entity/payment_request.dart';
import 'package:enzona/src/entity/refund.dart';
import 'package:enzona/src/enumerator/status_code.dart';
import 'package:test/test.dart';

import '../base_tests.dart';
import '../utils/matchers.dart';


void main() async {

  await init();

  group('Retrieve payments use cases', () {
    test('Get payments list', () async {
      final response = await enzona.paymentAPI.getPayments(pageIndex: 0, pageSize: 5);
      expect(response.isSuccessful, true);
      expect(response.headers.containsKey(Pagination.totalCountHeader), true);
    });

    group('Get payment byId', () {
      dynamic paymentId;
      setUp(() async {
        final response = await enzona.paymentAPI.getPayments(pageIndex: 0, pageSize: 5);
        if(response.body?.isNotEmpty ?? false) {
          paymentId = response.body![0].transactionUUID;
        }
      });

      test('Do get payment byId', () async {
        if(paymentId == null) {
          markTestSkipped('Do get payment byId skipped: No payment available to get by Id');
          return;
        }
        final response = await enzona.paymentAPI.getPayment(transactionUUID: paymentId);
        expect(response.isSuccessful, true);
        expect(response.body, isNotNull);
        expect(response.body?.statusCode, isNotNull);
      });
    });
  });

  group('Create payment use cases', () {
    final payment = PaymentRequest(
      returnUrl: "http://url.to.return.after.payment.confirmation",
      cancelUrl: "http://url.to.return.after.payment.cancellation",
      merchantOpId: PaymentRequest.generateRandomMerchantOpId(),
      currency: "CUP",
      amount: PaymentAmount(
        total: 30,
        details: PaymentAmountDetails(
          shipping: 0,
          tax: 0,
          discount: 0,
          tip: 0,
        ),
      ),
      items: [
        PaymentItem(
          name: "Payment Item 1",
          description: "Double item",
          quantity: 2,
          price: 15,
          tax: 0,
        )
      ],
      description: "This is an example payment description",
    );

    test('Create payment', () async {
      final response = await enzona.paymentAPI.createPayment(data: payment);
      expect(response.isSuccessful, true);
      expect(response.body, isNotNull);
      expect(response.body?.statusCode, StatusCode.pendiente);
    });

    test('Create and complete payment', () async {
      var response = await enzona.paymentAPI.createPayment(data: payment);
      expect(response.isSuccessful, true);
      expect(response.body, isNotNull);
      final createdPayment = response.body!;
      expect(createdPayment.transactionUUID, isNotNull);
      response = await enzona.paymentAPI.completePayment(transactionUUID: createdPayment.transactionUUID!);
      expect(response.isSuccessful, false);
      expect(response.error, GenericMatcher(
        onMatches: (item, matchState) =>
          item is ErrorResponse && item.code == StatusCode.transaccionNoConfirmada ? true : false
      ));
    });

    test('Create and cancel payment', () async {
      var response = await enzona.paymentAPI.createPayment(data: payment);
      expect(response.isSuccessful, true);
      expect(response.body, isNotNull);
      final createdPayment = response.body!;
      expect(createdPayment.transactionUUID, isNotNull);
      response = await enzona.paymentAPI.cancelPayment(transactionUUID: createdPayment.transactionUUID!);
      expect(response.isSuccessful, true);
      expect(response.body?.statusCode, StatusCode.fallida);
    });
  });

  group('Refund payment use cases', () {
    String? fullRefundPaymentId, partialRefundPaymentId;
    String? refundId;

    bool isResponseNoREDSAConnection(EnzonaResponse response) =>
      !response.isSuccessful &&
      response.error is ErrorResponse &&
      (response.error as ErrorResponse).code == StatusCode.noConexionREDSA;

    setUp(() async {
      final responsePayments = await enzona.paymentAPI.getPayments(pageIndex: 0, pageSize: 2, status: StatusCode.aceptada);
      if(responsePayments.body != null) {
        if(responsePayments.body!.isNotEmpty) {
          fullRefundPaymentId = responsePayments.body![0].transactionUUID;
        }
        if(responsePayments.body!.length > 1) {
          partialRefundPaymentId = responsePayments.body![1].transactionUUID;
        }
      }

      final responseRefunds = await enzona.paymentAPI.getRefunds(pageIndex: 0, pageSize: 1);
      if(responseRefunds.body != null) {
        if(responseRefunds.body!.isNotEmpty) {
          refundId = responseRefunds.body![0].transactionUUID;
        }
      }
    });

    test('Get refunds list', () async {
      final response = await enzona.paymentAPI.getRefunds(pageIndex: 0, pageSize: 5);
      expect(response.isSuccessful, true);
      expect(response.body, isNotNull);
    },);

    test('Get refund byId', () async {
      if(refundId == null) {
        markTestSkipped('Get refund byId skipped: No refund available to get by Id');
        return;
      }
      final response = await enzona.paymentAPI.getRefund(transactionUUID: refundId!);
      expect(response.isSuccessful, true);
      expect(response.body, isNotNull);
    },);

    test('Full payment refund', () async {
      if(fullRefundPaymentId == null) {
        markTestSkipped('Full payment refund skipped: No payment completed available to fully refund');
        return;
      }
      final response = await enzona.paymentAPI.refundPayment(transactionUUID: fullRefundPaymentId!);
      if (isResponseNoREDSAConnection(response)) {
        markTestSkipped('Full payment refund skipped: No REDSA connection');
        return;
      }
      expect(response.isSuccessful, true);
      expect(response.body, isNotNull);
      expect(response.body?.statusCode, StatusCode.devuelta);
    }, timeout: Timeout(Duration(seconds: 60)));

    test('Partial payment refund', () async {
      if(partialRefundPaymentId == null) {
        markTestSkipped('Partial payment refund skipped: No payment completed available to partially refund');
        return;
      }
      final refund = Refund(
        amount: PaymentAmount(
          total: 1,
        ),
        description: 'This is a partial refund'
      );
      final response = await enzona.paymentAPI.refundPayment(transactionUUID: partialRefundPaymentId!, data: refund);
      if (isResponseNoREDSAConnection(response)) {
        markTestSkipped('Partial payment refund skipped: No REDSA connection');
        return;
      }
      expect(response.isSuccessful, true);
      expect(response.body, isNotNull);
      expect(response.body?.statusCode, StatusCode.devuelta);
    }, timeout: Timeout(Duration(seconds: 60)));
  });
}
