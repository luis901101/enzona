import 'package:enzona/src/entity/payment_amount.dart';
import 'package:enzona/src/entity/payment_item.dart';
import 'package:enzona/src/entity/payment_link.dart';
import 'package:enzona/src/utils/json_utils.dart';
import 'package:enzona/src/utils/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable(includeIfNull: false)
class Payment extends Jsonable<Payment>{
  @JsonKey(name: "transaction_uuid")
  String? transactionUUID;
  @JsonKey(name: "transaction_code", fromJson: JsonUtils.intFromJson)//toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  int? transactionCode;
  @JsonKey(name: "transaction_signature")
  String? transactionSignature;
  @JsonKey(name: "transaction_denom")
  String? transactionDenom;
  @JsonKey(name: "transaction_description")
  String? transactionDescription;
  @JsonKey(name: "transaction_created_at")
  DateTime? transactionCreatedAt;
  @JsonKey(name: "transaction_updated_at")
  DateTime? transactionUpdatedAt;
  String? leaf;
  String? currency;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  String? status;
  @JsonKey(name: "status_code", fromJson: JsonUtils.intFromJson)//toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  int? statusCode;
  @JsonKey(name: "status_denom")
  String? statusDenom;
  String? description;
  @JsonKey(name: "invoice_number", fromJson: JsonUtils.intFromJson)//toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  int? invoiceNumber;
  @JsonKey(name: "merchant_op_id")
  String? merchantOpId;
  @JsonKey(name: "terminal_id")
  String? terminalId;
  PaymentAmount? amount;
  List<PaymentItem>? items;
  List<PaymentLink>? links;
  @JsonKey(toJson: JsonUtils.doubleToJsonString2Digits, fromJson: JsonUtils.doubleFromJson)//toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  double? commission;
  @JsonKey(name: "buyer_identity_code")
  String? buyerIdentityCode;
  @JsonKey(name: "merchant_uuid")
  String? merchantUUID;
  @JsonKey(name: "merchant_name")
  String? merchantName;
  @JsonKey(name: "merchant_alias")
  String? merchantAlias;
  @JsonKey(name: "merchant_avatar")
  String? merchantAvatar;
  @JsonKey(name: "refunded_amount")
  String? refundedAmount;
  String? username;
  String? name;
  String? lastname;
  String? avatar;

  Payment({
    this.transactionUUID,
    this.transactionCode,
    this.transactionSignature,
    this.transactionDenom,
    this.transactionDescription,
    this.transactionCreatedAt,
    this.transactionUpdatedAt,
    this.leaf,
    this.currency,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.statusCode,
    this.statusDenom,
    this.description,
    this.invoiceNumber,
    this.merchantOpId,
    this.terminalId,
    this.amount,
    this.items,
    this.links,
    this.commission,
    this.buyerIdentityCode,
    this.merchantUUID,
    this.merchantName,
    this.merchantAlias,
    this.merchantAvatar,
    this.refundedAmount,
    this.username,
    this.name,
    this.lastname,
    this.avatar});

  @override
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
  @override
  Payment? fromJsonMap(Map<String, dynamic>? json) => json != null ? Payment.fromJson(json) : null;
  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
