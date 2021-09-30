import 'package:enzona/src/entity/pagination.dart';
import 'package:test/test.dart';

import '../base_tests.dart';


void main() async {

  await init();

  group('Payments', () {
    test('Payments list', () async {
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

    group('Payment byId', () {
      dynamic paymentId;
      setUp(() async {
        final response = await enzona.paymentAPI.getPayments(pageIndex: 0, pageSize: 5);
        if(response.body?.isNotEmpty ?? false) {
          paymentId = response.body![0].transactionUUID;
        }
      });

      test('Do Payment byId', () async {
        if(paymentId != null) {
          final response = await enzona.paymentAPI.getPayment(transactionUUID: paymentId);
          expect(response.isSuccessful, true);
          expect(response.body, isNotNull);
          expect(response.body?.statusCode, isNotNull);
        }
      });
    });
  });
}
