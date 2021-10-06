import 'package:enzona/src/utils/json_utils.dart';
import 'package:enzona/src/utils/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_item.g.dart';

@JsonSerializable(includeIfNull: false)
class PaymentItem extends Jsonable<PaymentItem>{
  String? description;
  @JsonKey(fromJson: JsonUtils.intFromJson) //toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  int? quantity;
  @JsonKey(toJson: JsonUtils.doubleToJsonString2Digits, fromJson: JsonUtils.doubleFromJson) //toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  double? price;
  @JsonKey(toJson: JsonUtils.doubleToJsonString2Digits, fromJson: JsonUtils.doubleFromJson) //toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  double? tax;
  dynamic name; //Fixme: This field is a String when used in Payments and a List<String> when used in Refunds :( This file should always be String and the field for List<String> should be called "names"

  PaymentItem(
      {this.description, this.quantity, this.price, this.tax, this.name});
  
  @override
  Map<String, dynamic> toJson() => _$PaymentItemToJson(this);
  @override
  PaymentItem? fromJsonMap(Map<String, dynamic>? json) => json != null ? PaymentItem.fromJson(json) : null;
  factory PaymentItem.fromJson(Map<String, dynamic> json) =>
      _$PaymentItemFromJson(json);
}
