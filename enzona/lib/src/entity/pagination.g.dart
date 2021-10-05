// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination<T> _$PaginationFromJson<T extends Jsonable<Object>>(
        Map<String, dynamic> json) =>
    Pagination<T>(
      first: json['first'] as String?,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
      last: json['last'] as String?,
      total: JsonUtils.intFromJson(json['total']),
      totalAmount: JsonUtils.doubleFromJson(json['total_amount']),
    );

Map<String, dynamic> _$PaginationToJson<T extends Jsonable<Object>>(
    Pagination<T> instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('first', instance.first);
  writeNotNull('prev', instance.prev);
  writeNotNull('next', instance.next);
  writeNotNull('last', instance.last);
  writeNotNull('total', instance.total);
  writeNotNull('total_amount',
      JsonUtils.doubleToJsonString2Digits(instance.totalAmount));
  return val;
}
