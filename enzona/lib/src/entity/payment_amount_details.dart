import 'package:enzona/src/utils/json_utils.dart';
import 'package:enzona/src/utils/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_amount_details.g.dart';

@JsonSerializable(includeIfNull: false)
class PaymentAmountDetails extends Jsonable<PaymentAmountDetails>{
  @JsonKey(
      toJson: JsonUtils.toJsonString, fromJson: JsonUtils.doubleFromJson) //toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  double? shipping;
  @JsonKey(
      toJson: JsonUtils.toJsonString, fromJson: JsonUtils.doubleFromJson) //toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  double? tax;
  @JsonKey(
      toJson: JsonUtils.toJsonString, fromJson: JsonUtils.doubleFromJson) //toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  double? discount;
  @JsonKey(
      toJson: JsonUtils.toJsonString, fromJson: JsonUtils.doubleFromJson) //toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  double? tip;

  PaymentAmountDetails({this.shipping, this.tax, this.discount, this.tip});

  @override
  Map<String, dynamic> toJson() => _$PaymentAmountDetailsToJson(this);
  @override
  PaymentAmountDetails? fromJsonMap(Map<String, dynamic>? json) => json != null ? PaymentAmountDetails.fromJson(json) : null;
  factory PaymentAmountDetails.fromJson(Map<String, dynamic> json) =>
      _$PaymentAmountDetailsFromJson(json);
}
