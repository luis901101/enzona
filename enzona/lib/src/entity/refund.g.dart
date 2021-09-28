// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Refund _$RefundFromJson(Map<String, dynamic> json) => Refund(
      transactionStatusCode: json['transaction_status_code'] as String?,
      parentPaymentUUID: json['parent_payment_uuid'] as String?,
      refundName: json['refund_name'] as String?,
      refundLastname: json['refund_lastname'] as String?,
      refundAvatar: json['refund_avatar'] as String?,
    )
      ..transactionUuid = json['transaction_uuid'] as String?
      ..transactionDenom = json['transaction_denom'] as String?
      ..leaf = json['leaf'] as String?
      ..currency = json['currency'] as String?
      ..createdAt = json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String)
      ..updatedAt = json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String)
      ..status = json['status'] as String?
      ..statusCode = json['status_code'] as String?
      ..statusDenom = json['status_denom'] as String?
      ..description = json['description'] as String?
      ..invoiceNumber = json['invoice_number'] as String?
      ..merchantOpId = json['merchant_op_id'] as String?
      ..terminalId = json['terminal_id'] as String?
      ..amount = json['amount'] == null
          ? null
          : PaymentAmount.fromJson(json['amount'] as Map<String, dynamic>)
      ..items = (json['items'] as List<dynamic>?)
          ?.map((e) => PaymentItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..links = (json['links'] as List<dynamic>?)
          ?.map((e) => PaymentLink.fromJson(e as Map<String, dynamic>))
          .toList()
      ..commission = json['commission'] as String?
      ..returUrl = json['return_url'] as String?
      ..cancelUrl = json['cancel_url'] as String?
      ..buyerIdentityCode = json['buyer_identity_code'] as String?;

Map<String, dynamic> _$RefundToJson(Refund instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('transaction_uuid', instance.transactionUuid);
  writeNotNull('transaction_denom', instance.transactionDenom);
  writeNotNull('leaf', instance.leaf);
  writeNotNull('currency', instance.currency);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  writeNotNull('status', instance.status);
  writeNotNull('status_code', instance.statusCode);
  writeNotNull('status_denom', instance.statusDenom);
  writeNotNull('description', instance.description);
  writeNotNull('invoice_number', instance.invoiceNumber);
  writeNotNull('merchant_op_id', instance.merchantOpId);
  writeNotNull('terminal_id', instance.terminalId);
  writeNotNull('amount', instance.amount);
  writeNotNull('items', instance.items);
  writeNotNull('links', instance.links);
  writeNotNull('commission', instance.commission);
  writeNotNull('return_url', instance.returUrl);
  writeNotNull('cancel_url', instance.cancelUrl);
  writeNotNull('buyer_identity_code', instance.buyerIdentityCode);
  writeNotNull('transaction_status_code', instance.transactionStatusCode);
  writeNotNull('parent_payment_uuid', instance.parentPaymentUUID);
  writeNotNull('refund_name', instance.refundName);
  writeNotNull('refund_lastname', instance.refundLastname);
  writeNotNull('refund_avatar', instance.refundAvatar);
  return val;
}
