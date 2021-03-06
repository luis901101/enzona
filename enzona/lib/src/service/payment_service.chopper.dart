// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$PaymentService extends PaymentService {
  _$PaymentService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PaymentService;

  @override
  Future<Response<dynamic>> getPayments(
      {String? merchantUUID,
      int? pageSize,
      int? pageIndex,
      String? merchantOp,
      String? enzonaOp,
      int? status,
      DateTime? startDate,
      DateTime? endDate,
      Order? order,
      Map<String, dynamic> filters = const {}}) {
    final $url = '/payment/v1.0.0/payments';
    final $params = <String, dynamic>{
      'merchant_uuid': merchantUUID,
      'limit': pageSize,
      'offset': pageIndex,
      'merchant_op_filter': merchantOp,
      'enzona_op_filter': enzonaOp,
      'status_filter': status,
      'start_date_filter': startDate,
      'end_date_filter': endDate,
      'order_filter': order
    };
    $params.addAll(filters);
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPayment({required String transactionUUID}) {
    final $url = '/payment/v1.0.0/payments/$transactionUUID';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createPayment({required PaymentRequest data}) {
    final $url = '/payment/v1.0.0/payments';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> completePayment({required String transactionUUID}) {
    final $url = '/payment/v1.0.0/payments/$transactionUUID/complete';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> cancelPayment({required String transactionUUID}) {
    final $url = '/payment/v1.0.0/payments/$transactionUUID/cancel';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRefunds(
      {String? merchantUUID,
      String? transactionUUID,
      String? commerceRefundId,
      int? pageSize,
      int? pageIndex,
      int? status,
      DateTime? startDate,
      DateTime? endDate,
      Order? order,
      Map<String, dynamic> filters = const {}}) {
    final $url = '/payment/v1.0.0/payments/refunds';
    final $params = <String, dynamic>{
      'merchant_uuid': merchantUUID,
      'transaction_uuid': transactionUUID,
      'commerce_refund_id': commerceRefundId,
      'limit': pageSize,
      'offset': pageIndex,
      'status_filter': status,
      'start_date_filter': startDate,
      'end_date_filter': endDate,
      'order_filter': order
    };
    $params.addAll(filters);
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRefund({required String transactionUUID}) {
    final $url = '/payment/v1.0.0/payments/refund/$transactionUUID';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> refundPayment(
      {required String transactionUUID, required Refund? data}) {
    final $url = '/payment/v1.0.0/payments/$transactionUUID/refund';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
