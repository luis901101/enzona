
import 'package:enzona/src/base_api/enzona_response.dart';
import 'package:enzona/src/base_api/rest_api.dart' as rest_api;
import 'package:enzona/src/base_api/rest_api_retrofit_service.dart';
import 'package:enzona/src/entity/error_response.dart';
import 'package:enzona/src/entity/payment.dart';
import 'package:enzona/src/entity/payment_request.dart';
import 'package:enzona/src/entity/refund.dart';
import 'package:enzona/src/service/payment_service_retrofit.dart';

class PaymentAPIRetrofit extends RestAPIRetrofitService<PaymentServiceRetrofit, Payment, ErrorResponse> {

  PaymentAPIRetrofit() : super(PaymentServiceRetrofit(rest_api.restAPI.dio), dataType: Payment(), errorType: ErrorResponse());

  ///Payments
  Future<EnzonaResponse<List<Payment>>> getPayments({
    String? authorization,
    String? merchantUUID,
    int? pageSize,
    int? pageIndex,
    String? merchantOp,
    String? enzonaOp,
    int? status, ///Available values : 1111, 1112, 1113, 1114, 1115, 1116
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

  Future<EnzonaResponse<Payment>> getPayment({
    required String transactionUUID,
    String? authorization,
  }) async {
    return parseResponse(service.getPayment(transactionUUID: transactionUUID));
  }

  Future<EnzonaResponse<Payment>> createPayment({
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

  Future<EnzonaResponse<Payment>> completePayment({
    required String transactionUUID,
    String? authorization
  }) async {
    return parseResponse(
      service.completePayment(
        transactionUUID: transactionUUID,
      ),
    );
  }

  Future<EnzonaResponse<Payment>> cancelPayment({
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
  Future<EnzonaResponse<List<Refund>>> getRefunds({
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

  Future<EnzonaResponse<Refund>> getRefund({
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

  Future<EnzonaResponse<Refund>> refundPayment({
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