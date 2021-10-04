import 'package:enzona/src/entity/payment.dart';
import 'package:enzona/src/entity/payment_amount.dart';
import 'package:enzona/src/entity/payment_item.dart';
import 'package:enzona/src/entity/payment_link.dart';
import 'package:enzona/src/utils/json_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refund.g.dart';

@JsonSerializable(includeIfNull: false)
class Refund extends Payment {
  @JsonKey(name: "transaction_status_code", toJson: JsonUtils.toJsonString, fromJson: JsonUtils.intFromJson)//toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  int? transactionStatusCode;
  @JsonKey(name: "parent_payment_uuid")
  String? parentPaymentUUID;
  @JsonKey(name: "refund_name")
  String? refundName;
  @JsonKey(name: "refund_lastname")
  String? refundLastname;
  @JsonKey(name: "refund_avatar")
  String? refundAvatar;
  Refund(
      {this.transactionStatusCode,
      this.parentPaymentUUID,
      this.refundName,
      this.refundLastname,
      this.refundAvatar}) {
    statusCode ??= transactionStatusCode;
  }

  @override
  Map<String, dynamic> toJson() => _$RefundToJson(this);
  @override
  Refund? fromJsonMap(Map<String, dynamic>? json) => json != null ? Refund.fromJson(json) : null;
  factory Refund.fromJson(Map<String, dynamic> json) => _$RefundFromJson(json);
}
