
import 'package:chopper/chopper.dart';
import 'package:enzona/src/entity/refund.dart';
import 'package:http/http.dart' as http;
import 'package:enzona/src/base_api/api_service.dart';
import 'package:enzona/src/entity/payment.dart';
import 'package:enzona/src/service/payment_service.dart';

///Singleton
PaymentAPI api = PaymentAPI();
class PaymentAPI extends APIService<PaymentService, Payment> implements PaymentService{

  PaymentAPI() : super(PaymentService.createInstance(), Payment());

  ///Payments
  @override
  Future<Response<List<Payment>>> getPayments({
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
    return parseResponseAsList(service.getPayments(
      authorization: authorization ?? await getAuthorization(),
      merchantUUID: merchantUUID,
      pageSize: pageSize,
      pageIndex: pageIndex,
      merchantOp: merchantOp,
      enzonaOp: enzonaOp,
      status: status,
      startDate: startDate,
      endDate: endDate,
      order: order,
      filters: filters ?? {}));
  }

  @override
  Future<Response<Payment>> getPayment({
    required String transactionUUID,
    String? authorization,
  }) async {
    return parseResponse(service.getPayment(
        transactionUUID: transactionUUID,
        authorization: authorization ?? await getAuthorization()));
  }

  @override
  Future<Response<Payment>> createPayment({
    required Payment data,
    String? authorization
  }) async {
    return parseResponse(
      service.createPayment(
        data: data,
        authorization: authorization ?? await getAuthorization(),
      ),
    );
  }

  @override
  Future<Response<Payment>> completePayment({
    required String transactionUUID,
    String? authorization
  }) async {
    return parseResponse(
      service.completePayment(
        transactionUUID: transactionUUID,
        authorization: authorization ?? await getAuthorization(),
      ),
    );
  }

  @override
  Future<Response<Payment>> cancelPayment({
    required String transactionUUID,
    String? authorization
  }) async {
    return parseResponse(
      service.cancelPayment(
        transactionUUID: transactionUUID,
        authorization: authorization ?? await getAuthorization(),
      ),
    );
  }



  ///Refunds
  @override
  Future<Response<List<Refund>>> getRefunds({
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
    return genericParseResponseAsList(
      service.getRefunds(
        authorization: authorization ?? await getAuthorization(),
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
      Refund(),
    );
  }

  @override
  Future<Response<Refund>> getRefund({
    required String transactionUUID,
    String? authorization,
  }) async {
    return genericParseResponse(
      service.getPayment(
        transactionUUID: transactionUUID,
        authorization: authorization ?? await getAuthorization()
      ),
      Refund()
    );
  }

  @override
  Future<Response<Refund>> refundPayment({
    required String transactionUUID,
    Refund? data,
    String? authorization
  }) async {
    return genericParseResponse(
      service.refundPayment(
        transactionUUID: transactionUUID,
        data: data,
        authorization: authorization ?? await getAuthorization(),
      ),
      Refund()
    );
  }
}