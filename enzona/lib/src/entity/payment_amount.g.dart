// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_amount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentAmount _$PaymentAmountFromJson(Map<String, dynamic> json) =>
    PaymentAmount(
      total: JsonUtils.doubleFromJson(json['total']),
      details: json['details'] == null
          ? null
          : PaymentAmountDetails.fromJson(
              json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentAmountToJson(PaymentAmount instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('total', JsonUtils.toJsonString(instance.total));
  writeNotNull('details', instance.details);
  return val;
}
