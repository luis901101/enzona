// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentLink _$PaymentLinkFromJson(Map<String, dynamic> json) => PaymentLink(
      rel: json['rel'] as String?,
      method: json['method'] as String?,
      href: json['href'] as String?,
    );

Map<String, dynamic> _$PaymentLinkToJson(PaymentLink instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rel', instance.rel);
  writeNotNull('method', instance.method);
  writeNotNull('href', instance.href);
  return val;
}
