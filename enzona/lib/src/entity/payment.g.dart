// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      transactionUUID: json['transaction_uuid'] as String?,
      transactionCode: JsonUtils.intFromJson(json['transaction_code']),
      transactionSignature: json['transaction_signature'] as String?,
      transactionDenom: json['transaction_denom'] as String?,
      transactionDescription: json['transaction_description'] as String?,
      transactionCreatedAt: json['transaction_created_at'] == null
          ? null
          : DateTime.parse(json['transaction_created_at'] as String),
      transactionUpdatedAt: json['transaction_updated_at'] == null
          ? null
          : DateTime.parse(json['transaction_updated_at'] as String),
      leaf: json['leaf'] as String?,
      currency: json['currency'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      statusCode: JsonUtils.intFromJson(json['status_code']),
      statusDenom: json['status_denom'] as String?,
      description: json['description'] as String?,
      invoiceNumber: JsonUtils.intFromJson(json['invoice_number']),
      merchantOpId: json['merchant_op_id'] as String?,
      terminalId: json['terminal_id'] as String?,
      amount: json['amount'] == null
          ? null
          : PaymentAmount.fromJson(json['amount'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => PaymentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => PaymentLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      commission: JsonUtils.doubleFromJson(json['commission']),
      returnUrl: json['return_url'] as String?,
      cancelUrl: json['cancel_url'] as String?,
      buyerIdentityCode: json['buyer_identity_code'] as String?,
      merchantUUID: json['merchant_uuid'] as String?,
      merchantName: json['merchant_name'] as String?,
      merchantAlias: json['merchant_alias'] as String?,
      merchantAvatar: json['merchant_avatar'] as String?,
      refundedAmount: json['refunded_amount'] as String?,
      username: json['username'] as String?,
      name: json['name'] as String?,
      lastname: json['lastname'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('transaction_uuid', instance.transactionUUID);
  writeNotNull('transaction_code', instance.transactionCode);
  writeNotNull('transaction_signature', instance.transactionSignature);
  writeNotNull('transaction_denom', instance.transactionDenom);
  writeNotNull('transaction_description', instance.transactionDescription);
  writeNotNull('transaction_created_at',
      instance.transactionCreatedAt?.toIso8601String());
  writeNotNull('transaction_updated_at',
      instance.transactionUpdatedAt?.toIso8601String());
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
  writeNotNull(
      'commission', JsonUtils.doubleToJsonString2Digits(instance.commission));
  writeNotNull('return_url', instance.returnUrl);
  writeNotNull('cancel_url', instance.cancelUrl);
  writeNotNull('buyer_identity_code', instance.buyerIdentityCode);
  writeNotNull('merchant_uuid', instance.merchantUUID);
  writeNotNull('merchant_name', instance.merchantName);
  writeNotNull('merchant_alias', instance.merchantAlias);
  writeNotNull('merchant_avatar', instance.merchantAvatar);
  writeNotNull('refunded_amount', instance.refundedAmount);
  writeNotNull('username', instance.username);
  writeNotNull('name', instance.name);
  writeNotNull('lastname', instance.lastname);
  writeNotNull('avatar', instance.avatar);
  return val;
}
