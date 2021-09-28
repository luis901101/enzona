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
      {String? authorization,
      dynamic merchantUUID,
      int? pageSize,
      int? pageIndex,
      dynamic merchantOp,
      dynamic enzonaOp,
      dynamic status,
      String? startDate,
      String? endDate,
      String? order,
      Map<String, dynamic> filters = const {}}) {
    final $url = '/payments';
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
    final $headers = {
      if (authorization != null) 'Authorization': authorization,
    };

    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPayment(
      {required String authorization, required String transactionUUID}) {
    final $url = '/payments/$transactionUUID';
    final $headers = {
      'Authorization': authorization,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createPayment(
      {required String authorization, required Payment data}) {
    final $url = '/payments';
    final $headers = {
      'Authorization': authorization,
    };

    final $body = data;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> completePayment(
      {required String authorization, required String transactionUUID}) {
    final $url = '/payments/$transactionUUID/complete';
    final $headers = {
      'Authorization': authorization,
    };

    final $request = Request('POST', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> cancelPayment(
      {required String authorization, required String transactionUUID}) {
    final $url = '/payments/$transactionUUID/cancel';
    final $headers = {
      'Authorization': authorization,
    };

    final $request = Request('POST', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRefunds(
      {String? authorization,
      dynamic merchantUUID,
      dynamic transactionUUID,
      dynamic commerceRefundId,
      int? pageSize,
      int? pageIndex,
      dynamic status,
      String? startDate,
      String? endDate,
      String? order,
      Map<String, dynamic> filters = const {}}) {
    final $url = '/payments/refunds';
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
    final $headers = {
      if (authorization != null) 'Authorization': authorization,
    };

    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRefund(
      {required String authorization, required String transactionUUID}) {
    final $url = '/payments/refund/$transactionUUID';
    final $headers = {
      'Authorization': authorization,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> refundPayment(
      {required String authorization,
      required String transactionUUID,
      required Refund? data}) {
    final $url = '/payments/$transactionUUID/refund';
    final $headers = {
      'Authorization': authorization,
    };

    final $body = data;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}