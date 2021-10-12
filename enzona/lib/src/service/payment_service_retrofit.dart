

import 'package:enzona/enzona.dart';
import 'package:enzona/src/base_api/rest_api_service.dart';
import 'package:enzona/src/entity/payment_request.dart';
import 'package:enzona/src/entity/refund.dart';
import 'package:enzona/src/enumerator/order.dart';
import 'package:enzona/src/utils/date_time_utils.dart';
import 'package:enzona/src/utils/params.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'payment_service_retrofit.g.dart';

@RestApi()
abstract class PaymentServiceRetrofit {
  factory PaymentServiceRetrofit(Dio dio, {String? baseUrl}) {
    return _PaymentServiceRetrofit(
      dio,
      baseUrl: '${dio.options.baseUrl}/payment/v1.0.0'
    );
  }

  ///Payments
  @GET('/payments')
  @Headers(RestAPIService.defaultHeaders)
  Future<HttpResponse> getPayments({
    @Query(Params.merchantUUID) String? merchantUUID,
    @Query(Params.pageSize) int? pageSize,
    @Query(Params.pageIndex) int? pageIndex,
    @Query(Params.merchantOp) String? merchantOp,
    @Query(Params.enzonaOp) String? enzonaOp,
    @Query(Params.status) int? status, ///Available values : 1111, 1112, 1113, 1114, 1115, 1116
    @Query(Params.startDate) DateTime? startDate,
    @Query(Params.endDate) DateTime? endDate,
    @Query(Params.order) Order? order, ///Available values : asc, desc
    @Queries() Map<String, dynamic> filters = const {} ///Use filters map for more dynamic filtering
  });

  @GET('/payments/{transaction_uuid}')
  @Headers(RestAPIService.defaultHeaders)
  Future<HttpResponse<Payment?>> getPayment({
    @Path('transaction_uuid') required String transactionUUID,
  });

  @POST('/payments')
  @Headers(RestAPIService.defaultHeaders)
  Future<HttpResponse<Payment?>> createPayment({
    @Body() required PaymentRequest data,
  });

  @POST('/payments/{transaction_uuid}/complete')
  @Headers(RestAPIService.defaultHeaders)
  Future<HttpResponse<Payment?>> completePayment({
    @Path('transaction_uuid') required String transactionUUID,
  });

  @POST('/payments/{transaction_uuid}/cancel')
  @Headers(RestAPIService.defaultHeaders)
  Future<HttpResponse<Payment?>> cancelPayment({
    @Path('transaction_uuid') required String transactionUUID,
  });



  ///Refunds
  @GET('/payments/refunds')
  @Headers(RestAPIService.defaultHeaders)
  Future<HttpResponse> getRefunds({
    @Query(Params.merchantUUID) String? merchantUUID,
    @Query(Params.transactionUUID) String? transactionUUID,
    @Query(Params.commerceRefundId) String? commerceRefundId,
    @Query(Params.pageSize) int? pageSize,
    @Query(Params.pageIndex) int? pageIndex,
    @Query(Params.status) int? status, ///Available values : 1111, 1112, 1113, 1114, 1115, 1116
    @Query(Params.startDate) DateTime? startDate,
    @Query(Params.endDate) DateTime? endDate,
    @Query(Params.order) Order? order, ///Available values : asc, desc
    @Queries() Map<String, dynamic> filters = const {} ///Use filters map for more dynamic filtering
  });

  @GET('/payments/refund/{transaction_uuid}')
  @Headers(RestAPIService.defaultHeaders)
  Future<HttpResponse<Refund?>> getRefund({
    @Path('transaction_uuid') required String transactionUUID,
  });

  @POST('/payments/{transaction_uuid}/refund')
  @Headers(RestAPIService.defaultHeaders)
  Future<HttpResponse<Refund?>> refundPayment({
    @Path('transaction_uuid') required String transactionUUID,
    @Body() required Refund? data,
  });
}