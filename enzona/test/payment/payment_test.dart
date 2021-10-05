import 'package:enzona/src/entity/error_response.dart';
import 'package:enzona/src/entity/pagination.dart';
import 'package:enzona/src/entity/payment.dart';
import 'package:enzona/src/entity/payment_amount.dart';
import 'package:enzona/src/entity/payment_amount_details.dart';
import 'package:enzona/src/entity/payment_item.dart';
import 'package:enzona/src/enumerator/error_code.dart';
import 'package:test/test.dart';

import '../base_tests.dart';
import '../utils/matchers.dart';


void main() async {

  await init();

  group('Payments retrieve', () {
    test('Get payments list', () async {
      // expect(await enzona.paymentAPI.getPayments(pageIndex: 0, pageSize: 5), GenericMatcher(
      //   onMatches: (item, matchState) {
      //     if(item is Response) {
      //       return item.isSuccessful;
      //     }
      //     return false;
      //   }
      // ));

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
        if(paymentId != null) {
          final response = await enzona.paymentAPI.getPayment(transactionUUID: paymentId);
          expect(response.isSuccessful, true);
          expect(response.body, isNotNull);
          expect(response.body?.statusCode, isNotNull);
        }
      });
    });
  });

  group('Create payment use cases', () {
    final payment = Payment(
      description: "This is an example payment description",
      currency: "CUP",
      amount: PaymentAmount(
        total: 30.00,
        details: PaymentAmountDetails(
          shipping: 0.00,
          tax: 0.00,
          discount: 0.00,
          tip: 0.00,
        ),
      ),
      items: [
        PaymentItem(
          name: "Payment Item 1",
          description: "Double item",
          quantity: 2,
          price: 15.00,
          tax: 0.00,
        )
      ],
      merchantOpId: "123456789123",
      // invoiceNumber: 1,
      // terminalId: "1",
      returnUrl: "http://url.to.return.after.payment.confirmation",
      cancelUrl: "http://url.to.return.after.payment.cancellation"
    );

    test('Create payment', () async {
      final response = await enzona.paymentAPI.createPayment(data: payment);
      expect(response.isSuccessful, true);
      expect(response.body, isNotNull);
      expect(response.body?.statusCode, ErrorCode.pendiente);
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
          item is ErrorResponse && item.code == ErrorCode.transaccionNoConfirmada ? true : false
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
      expect(response.body?.statusCode, ErrorCode.fallida);
    });
  });
}
