// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentItem _$PaymentItemFromJson(Map<String, dynamic> json) => PaymentItem(
      description: json['description'] as String?,
      quantity: JsonUtils.intFromJsonString(json['quantity']),
      price: JsonUtils.doubleFromJsonString(json['price']),
      tax: JsonUtils.doubleFromJsonString(json['tax']),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PaymentItemToJson(PaymentItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('quantity', JsonUtils.toJsonString(instance.quantity));
  writeNotNull('price', JsonUtils.toJsonString(instance.price));
  writeNotNull('tax', JsonUtils.toJsonString(instance.tax));
  writeNotNull('name', instance.name);
  return val;
}
