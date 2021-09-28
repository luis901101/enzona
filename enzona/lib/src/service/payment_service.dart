
import 'package:chopper/chopper.dart';
import 'package:enzona/src/base_api/api_service.dart';
import 'package:enzona/src/entity/payment.dart';
import 'package:enzona/src/entity/refund.dart';

part 'payment_service.chopper.dart';

@ChopperApi(baseUrl: '/')
abstract class PaymentService extends ChopperService {
  static PaymentService createInstance([ChopperClient? client]) => _$PaymentService(client);

  ///Payments
  @Get(path: 'payments', headers: APIService.defaultHeaders)
  Future<Response> getPayments({
    @Header(APIService.authorizationKey) String? authorization,
    @Query('merchant_uuid') dynamic merchantUUID,
    @Query('limit') int? pageSize,
    @Query('offset') int? pageIndex,
    @Query('merchant_op_filter') dynamic merchantOp,
    @Query('enzona_op_filter') dynamic enzonaOp,
    @Query('status_filter') dynamic status, ///Available values : 1111, 1112, 1113, 1114, 1115, 1116
    @Query('start_date_filter') String? startDate,
    @Query('end_date_filter') String? endDate,
    @Query('order_filter') String? order, ///Available values : asc, desc
    @QueryMap() Map<String, dynamic> filters = const {} ///Use filters map for more dynamic filtering
  });

  @Get(path: 'payments/{transaction_uuid}', headers: APIService.defaultHeaders)
  Future<Response> getPayment({
    @Header(APIService.authorizationKey) required String authorization,
    @Path('transaction_uuid') required String transactionUUID,
  });

  @Post(path: "payments", headers: APIService.defaultHeaders)
  Future<Response> createPayment({
    @Header(APIService.authorizationKey) required String authorization,
    @Body() required Payment data,
  });

  @Post(path: "payments/{transaction_uuid}/complete", optionalBody: true, headers: APIService.defaultHeaders)
  Future<Response> completePayment({
    @Header(APIService.authorizationKey) required String authorization,
    @Path('transaction_uuid') required String transactionUUID,
  });

  @Post(path: "payments/{transaction_uuid}/cancel", optionalBody: true, headers: APIService.defaultHeaders)
  Future<Response> cancelPayment({
    @Header(APIService.authorizationKey) required String authorization,
    @Path('transaction_uuid') required String transactionUUID,
  });



  ///Refunds
  @Get(path: 'payments/refunds', headers: APIService.defaultHeaders)
  Future<Response> getRefunds({
    @Header(APIService.authorizationKey) String? authorization,
    @Query('merchant_uuid') dynamic merchantUUID,
    @Query('transaction_uuid') dynamic transactionUUID,
    @Query('commerce_refund_id') dynamic commerceRefundId,
    @Query('limit') int? pageSize,
    @Query('offset') int? pageIndex,
    @Query('status_filter') dynamic status, ///Available values : 1111, 1112, 1113, 1114, 1115, 1116
    @Query('start_date_filter') String? startDate,
    @Query('end_date_filter') String? endDate,
    @Query('order_filter') String? order, ///Available values : asc, desc
    @QueryMap() Map<String, dynamic> filters = const {} ///Use filters map for more dynamic filtering
  });

  @Get(path: 'payments/refund/{transaction_uuid}', headers: APIService.defaultHeaders)
  Future<Response> getRefund({
    @Header(APIService.authorizationKey) required String authorization,
    @Path('transaction_uuid') required String transactionUUID,
  });

  @Post(path: "payments/{transaction_uuid}/refund", headers: APIService.defaultHeaders)
  Future<Response> refundPayment({
    @Header(APIService.authorizationKey) required String authorization,
    @Path('transaction_uuid') required String transactionUUID,
    @Body() required Refund? data,
  });
}