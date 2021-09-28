import 'package:enzona/src/entity/payment_amount_details.dart';
import 'package:enzona/src/utils/json_utils.dart';
import 'package:enzona/src/utils/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_amount.g.dart';

@JsonSerializable(includeIfNull: false)
class PaymentAmount extends Jsonable<PaymentAmount>{
  @JsonKey(
      toJson: JsonUtils.toJsonString, fromJson: JsonUtils.doubleFromJsonString) //toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  double? total;
  PaymentAmountDetails? details;

  PaymentAmount({this.total, this.details});

  @override
  Map<String, dynamic> toJson() => _$PaymentAmountToJson(this);
  @override
  PaymentAmount? fromJsonMap(Map<String, dynamic>? json) => json != null ? PaymentAmount.fromJson(json) : null;
  factory PaymentAmount.fromJson(Map<String, dynamic> json) =>
      _$PaymentAmountFromJson(json);
}
