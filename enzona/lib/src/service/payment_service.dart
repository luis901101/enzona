
import 'package:chopper/chopper.dart';
import 'package:enzona/src/base_api/rest_api_service.dart';
import 'package:enzona/src/entity/payment_request.dart';
import 'package:enzona/src/entity/refund.dart';
import 'package:enzona/src/enumerator/order.dart';
import 'package:enzona/src/utils/params.dart';

part 'payment_service.chopper.dart';

@ChopperApi(baseUrl: '/payment/v1.0.0/')
abstract class PaymentService extends ChopperService {
  static PaymentService createInstance([ChopperClient? client]) => _$PaymentService(client);

  ///Payments
  @Get(path: 'payments', headers: RestAPIService.defaultHeaders)
  Future<Response> getPayments({
    @Query(Params.merchantUUID) String? merchantUUID,
    @Query(Params.pageSize) int? pageSize,
    @Query(Params.pageIndex) int? pageIndex,
    @Query(Params.merchantOp) String? merchantOp,
    @Query(Params.enzonaOp) String? enzonaOp,
    @Query(Params.status) int? status, ///Available values : 1111, 1112, 1113, 1114, 1115, 1116
    @Query(Params.startDate) DateTime? startDate,
    @Query(Params.endDate) DateTime? endDate,
    @Query(Params.order) Order? order, ///Available values : asc, desc
    @QueryMap() Map<String, dynamic> filters = const {} ///Use filters map for more dynamic filtering
  });

  @Get(path: 'payments/{transaction_uuid}', headers: RestAPIService.defaultHeaders)
  Future<Response> getPayment({
    @Path('transaction_uuid') required String transactionUUID,
  });

  @Post(path: "payments", headers: RestAPIService.defaultHeaders)
  Future<Response> createPayment({
    @Body() required PaymentRequest data,
  });

  @Post(path: "payments/{transaction_uuid}/complete", optionalBody: true, headers: RestAPIService.defaultHeaders)
  Future<Response> completePayment({
    @Path('transaction_uuid') required String transactionUUID,
  });

  @Post(path: "payments/{transaction_uuid}/cancel", optionalBody: true, headers: RestAPIService.defaultHeaders)
  Future<Response> cancelPayment({
    @Path('transaction_uuid') required String transactionUUID,
  });



  ///Refunds
  @Get(path: 'payments/refunds', headers: RestAPIService.defaultHeaders)
  Future<Response> getRefunds({
    @Query(Params.merchantUUID) String? merchantUUID,
    @Query(Params.transactionUUID) String? transactionUUID,
    @Query(Params.commerceRefundId) String? commerceRefundId,
    @Query(Params.pageSize) int? pageSize,
    @Query(Params.pageIndex) int? pageIndex,
    @Query(Params.status) int? status, ///Available values : 1111, 1112, 1113, 1114, 1115, 1116
    @Query(Params.startDate) DateTime? startDate,
    @Query(Params.endDate) DateTime? endDate,
    @Query(Params.order) Order? order, ///Available values : asc, desc
    @QueryMap() Map<String, dynamic> filters = const {} ///Use filters map for more dynamic filtering
  });

  @Get(path: 'payments/refund/{transaction_uuid}', headers: RestAPIService.defaultHeaders)
  Future<Response> getRefund({
    @Path('transaction_uuid') required String transactionUUID,
  });

  @Post(path: "payments/{transaction_uuid}/refund", headers: RestAPIService.defaultHeaders)
  Future<Response> refundPayment({
    @Path('transaction_uuid') required String transactionUUID,
    @Body() required Refund? data,
  });
}