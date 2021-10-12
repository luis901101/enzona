// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_service_retrofit.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _PaymentServiceRetrofit implements PaymentServiceRetrofit {
  _PaymentServiceRetrofit(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<dynamic>> getPayments(
      {merchantUUID,
      pageSize,
      pageIndex,
      merchantOp,
      enzonaOp,
      status,
      startDate,
      endDate,
      order,
      filters = const {}}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'merchant_uuid': merchantUUID,
      r'limit': pageSize,
      r'offset': pageIndex,
      r'merchant_op_filter': merchantOp,
      r'enzona_op_filter': enzonaOp,
      r'status_filter': status,
      r'start_date_filter': startDate,
      r'end_date_filter': endDate,
      r'order_filter': order
    };
    queryParameters.addAll(filters);
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '/payments',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<Payment?>> getPayment({required transactionUUID}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<Payment>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/payments/$transactionUUID',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null ? null : Payment.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<Payment?>> createPayment({required data}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<Payment>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/payments',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null ? null : Payment.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<Payment?>> completePayment(
      {required transactionUUID}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<Payment>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/payments/$transactionUUID/complete',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null ? null : Payment.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<Payment?>> cancelPayment(
      {required transactionUUID}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<Payment>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/payments/$transactionUUID/cancel',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null ? null : Payment.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> getRefunds(
      {merchantUUID,
      transactionUUID,
      commerceRefundId,
      pageSize,
      pageIndex,
      status,
      startDate,
      endDate,
      order,
      filters = const {}}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'merchant_uuid': merchantUUID,
      r'transaction_uuid': transactionUUID,
      r'commerce_refund_id': commerceRefundId,
      r'limit': pageSize,
      r'offset': pageIndex,
      r'status_filter': status,
      r'start_date_filter': startDate,
      r'end_date_filter': endDate,
      r'order_filter': order
    };
    queryParameters.addAll(filters);
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '/payments/refunds',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<Refund?>> getRefund({required transactionUUID}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<Refund>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/payments/refund/$transactionUUID',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null ? null : Refund.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<Refund?>> refundPayment(
      {required transactionUUID, data}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<Refund>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/payments/$transactionUUID/refund',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null ? null : Refund.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
