
import 'package:enzona/src/apiservice/payment_api.dart';
import 'package:enzona/src/base_api/e_response.dart';
import 'package:enzona/src/base_api/rest_api.dart' as rest_api;
import 'package:enzona/src/entity/payment.dart';
import 'package:enzona/src/entity/payment_request.dart';
import 'package:enzona/src/entity/refund.dart';
import 'package:enzona/src/enumerator/order.dart';
import 'package:enzona/src/service/payment_service_retrofit.dart';

class PaymentAPIRetrofit extends PaymentAPI<PaymentServiceRetrofit, Payment> {

  PaymentAPIRetrofit() : super(PaymentServiceRetrofit(rest_api.restAPI.dio), dataType: Payment());

  ///Payments
  @override
  Future<EResponse<List<Payment>>> getPayments({
    String? authorization,
    String? merchantUUID,
    int? pageSize,
    int? pageIndex,
    String? merchantOp,
    String? enzonaOp,
    int? status, ///Available values : 1111, 1112, 1113, 1114, 1115, 1116
    DateTime? startDate,
    DateTime? endDate,
    Order? order, ///Available values : asc, desc
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

  @override
  Future<EResponse<Payment>> getPayment({
    required String transactionUUID,
    String? authorization,
  }) async {
    return parseResponse(service.getPayment(transactionUUID: transactionUUID));
  }

  @override
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

  @override
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

  @override
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
  @override
  Future<EResponse<List<Refund>>> getRefunds({
    String? authorization,
    dynamic merchantUUID,
    dynamic transactionUUID,
    dynamic commerceRefundId,
    int? pageSize,
    int? pageIndex,
    dynamic status, ///Available values : 1111, 1112, 1113, 1114, 1115, 1116
    DateTime? startDate,
    DateTime? endDate,
    Order? order, ///Available values : asc, desc
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

  @override
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

  @override
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