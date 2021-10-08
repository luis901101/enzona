
import 'package:enzona/src/base_api/e_response.dart';
import 'package:enzona/src/base_api/rest_api_retrofit_service.dart';
import 'package:enzona/src/entity/error_response.dart';
import 'package:enzona/src/entity/payment_request.dart';
import 'package:enzona/src/entity/refund.dart';
import 'package:enzona/src/entity/payment.dart';
import 'package:enzona/src/service/payment_service.dart';

class PaymentAPI extends RestAPIRetrofitService<PaymentService, Payment, ErrorResponse> {

  PaymentAPI() : super(PaymentService.createInstance(), dataType: Payment(), errorType: ErrorResponse());

  ///Payments
  Future<EResponse<List<Payment>>> getPayments({
    String? authorization,
    dynamic merchantUUID,
    int? pageSize,
    int? pageIndex,
    dynamic merchantOp,
    dynamic enzonaOp,
    dynamic status, ///Available values : 1111, 1112, 1113, 1114, 1115, 1116
    String? startDate,
    String? endDate,
    String? order, ///Available values : asc, desc
    Map<String, dynamic>? filters ///Use filters map for more dynamic filtering
  }) async {
    return parsePaginationResponseAsList(
      service.getPayments(
        merchantUUID: merchantUUID,
        pageSize: pageSize,
        pageIndex: pageIndex,
        merchantOp: merchantOp,
        enzonaOp: enzonaOp,
        status: status,
        startDate: startDate,
        endDate: endDate,
        order: order,
        filters: filters ?? {}
      ),
      dataListParam: 'payments'
    );
  }

  Future<EResponse<Payment>> getPayment({
    required String transactionUUID,
    String? authorization,
  }) async {
    return parseResponse(service.getPayment(transactionUUID: transactionUUID));
  }

  Future<EResponse<Payment>> createPayment({
    required PaymentRequest data,
    String? authorization
  }) async {
    final response = await parseResponse(
      service.createPayment(
        data: data,
      ),
    );
    if(response.isSuccessful && response.body != null) {
      response.body!..returnUrl = data.returnUrl..cancelUrl = data.cancelUrl;
    }
    return response;
  }

  Future<EResponse<Payment>> completePayment({
    required String transactionUUID,
    String? authorization
  }) async {
    return parseResponse(
      service.completePayment(
        transactionUUID: transactionUUID,
      ),
    );
  }

  Future<EResponse<Payment>> cancelPayment({
    required String transactionUUID,
    String? authorization
  }) async {
    return parseResponse(
      service.cancelPayment(
        transactionUUID: transactionUUID,
      ),
    );
  }



  ///Refunds
  Future<EResponse<List<Refund>>> getRefunds({
    String? authorization,
    dynamic merchantUUID,
    dynamic transactionUUID,
    dynamic commerceRefundId,
    int? pageSize,
    int? pageIndex,
    dynamic status, ///Available values : 1111, 1112, 1113, 1114, 1115, 1116
    String? startDate,
    String? endDate,
    String? order, ///Available values : asc, desc
    Map<String, dynamic>? filters ///Use filters map for more dynamic filtering
  }) async {
    return genericParsePaginationResponseAsList(
      service.getRefunds(
        merchantUUID: merchantUUID,
        transactionUUID: transactionUUID,
        commerceRefundId: commerceRefundId,
        pageSize: pageSize,
        pageIndex: pageIndex,
        status: status,
        startDate: startDate,
        endDate: endDate,
        order: order,
        filters: filters ?? {}
      ),
      dataType: Refund(),
      dataListParam: 'refunds'
    );
  }

  Future<EResponse<Refund>> getRefund({
    required String transactionUUID,
    String? authorization,
  }) async {
    return genericParseResponse(
      service.getRefund(
        transactionUUID: transactionUUID,
      ),
      dataType: Refund()
    );
  }

  Future<EResponse<Refund>> refundPayment({
    required String transactionUUID,
    Refund? data,
    String? authorization
  }) async {
    return genericParseResponse(
      service.refundPayment(
        transactionUUID: transactionUUID,
        data: data,
      ),
      dataType: Refund()
    );
  }
}