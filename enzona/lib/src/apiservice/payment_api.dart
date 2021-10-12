
import 'package:enzona/src/base_api/e_response.dart';
import 'package:enzona/src/base_api/rest_api_service.dart';
import 'package:enzona/src/entity/error_response.dart';
import 'package:enzona/src/entity/payment_request.dart';
import 'package:enzona/src/entity/refund.dart';
import 'package:enzona/src/entity/payment.dart';
import 'package:enzona/src/enumerator/order.dart';
import 'package:enzona/src/utils/jsonable.dart';

abstract class PaymentAPI<I, DataType extends Jsonable> extends RestAPIService<I, DataType, ErrorResponse> {

  PaymentAPI(I service, {required DataType dataType}) : super(service, dataType: dataType, errorType: ErrorResponse());

  ///Payments
  Future<EResponse<List<Payment>>> getPayments({
    String? authorization,
    String? merchantUUID,
    int? pageSize,
    int? pageIndex,
    String? merchantOp,
    String? enzonaOp,
    int? status, ///Available values : 1111, 1112, 1113, 1114, 1115, 1116
    String? startDate,
    String? endDate,
    Order? order, ///Available values : asc, desc
    Map<String, dynamic>? filters ///Use filters map for more dynamic filtering
  });

  Future<EResponse<Payment>> getPayment({
    required String transactionUUID,
    String? authorization,
  });

  Future<EResponse<Payment>> createPayment({
    required PaymentRequest data,
    String? authorization
  });

  Future<EResponse<Payment>> completePayment({
    required String transactionUUID,
    String? authorization
  });

  Future<EResponse<Payment>> cancelPayment({
    required String transactionUUID,
    String? authorization
  });



  ///Refunds
  Future<EResponse<List<Refund>>> getRefunds({
    String? authorization,
    String? merchantUUID,
    String? transactionUUID,
    String? commerceRefundId,
    int? pageSize,
    int? pageIndex,
    int? status, ///Available values : 1111, 1112, 1113, 1114, 1115, 1116
    String? startDate,
    String? endDate,
    Order? order, ///Available values : asc, desc
    Map<String, dynamic>? filters ///Use filters map for more dynamic filtering
  });

  Future<EResponse<Refund>> getRefund({
    required String transactionUUID,
    String? authorization,
  });

  Future<EResponse<Refund>> refundPayment({
    required String transactionUUID,
    Refund? data,
    String? authorization
  });
}