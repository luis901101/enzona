import 'package:enzona/src/utils/json_utils.dart';
import 'package:enzona/src/utils/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_item.g.dart';

@JsonSerializable(includeIfNull: false)
class PaymentItem extends Jsonable<PaymentItem>{
  String? description;
  @JsonKey(
      toJson: JsonUtils.toJsonString, fromJson: JsonUtils.intFromJsonString) //toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  int? quantity;
  @JsonKey(
      toJson: JsonUtils.toJsonString, fromJson: JsonUtils.doubleFromJsonString) //toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  double? price;
  @JsonKey(
      toJson: JsonUtils.toJsonString, fromJson: JsonUtils.doubleFromJsonString) //toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  double? tax;
  String? name;

  PaymentItem(
      {this.description, this.quantity, this.price, this.tax, this.name});
  
  @override
  Map<String, dynamic> toJson() => _$PaymentItemToJson(this);
  @override
  PaymentItem? fromJsonMap(Map<String, dynamic>? json) => json != null ? PaymentItem.fromJson(json) : null;
  factory PaymentItem.fromJson(Map<String, dynamic> json) =>
      _$PaymentItemFromJson(json);
}
