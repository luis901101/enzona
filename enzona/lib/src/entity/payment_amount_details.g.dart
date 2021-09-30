// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_amount_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentAmountDetails _$PaymentAmountDetailsFromJson(
        Map<String, dynamic> json) =>
    PaymentAmountDetails(
      shipping: JsonUtils.doubleFromJson(json['shipping']),
      tax: JsonUtils.doubleFromJson(json['tax']),
      discount: JsonUtils.doubleFromJson(json['discount']),
      tip: JsonUtils.doubleFromJson(json['tip']),
    );

Map<String, dynamic> _$PaymentAmountDetailsToJson(
    PaymentAmountDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('shipping', JsonUtils.toJsonString(instance.shipping));
  writeNotNull('tax', JsonUtils.toJsonString(instance.tax));
  writeNotNull('discount', JsonUtils.toJsonString(instance.discount));
  writeNotNull('tip', JsonUtils.toJsonString(instance.tip));
  return val;
}
