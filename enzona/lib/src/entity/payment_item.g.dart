// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentItem _$PaymentItemFromJson(Map<String, dynamic> json) => PaymentItem(
      description: json['description'] as String?,
      quantity: JsonUtils.intFromJson(json['quantity']),
      price: JsonUtils.doubleFromJson(json['price']),
      tax: JsonUtils.doubleFromJson(json['tax']),
      name: json['name'],
    );

Map<String, dynamic> _$PaymentItemToJson(PaymentItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('price', JsonUtils.doubleToJsonString2Digits(instance.price));
  writeNotNull('tax', JsonUtils.doubleToJsonString2Digits(instance.tax));
  writeNotNull('name', instance.name);
  return val;
}
