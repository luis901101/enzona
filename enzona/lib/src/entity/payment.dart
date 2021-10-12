import 'package:enzona/src/entity/payment_amount.dart';
import 'package:enzona/src/entity/payment_item.dart';
import 'package:enzona/src/entity/payment_link.dart';
import 'package:enzona/src/utils/json_utils.dart';
import 'package:enzona/src/utils/jsonable.dart';
import 'package:enzona/src/utils/params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable(includeIfNull: false)
class Payment extends Jsonable<Payment>{
  @JsonKey(name: Params.transactionUUID)
  String? transactionUUID;
  @JsonKey(name: Params.transactionCode, fromJson: JsonUtils.intFromJson)//toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  int? transactionCode;
  @JsonKey(name: Params.transactionSignature)
  String? transactionSignature;
  @JsonKey(name: Params.transactionDenom)
  String? transactionDenom;
  @JsonKey(name: Params.transactionDescription)
  String? transactionDescription;
  @JsonKey(name: Params.transactionCreatedAt)
  DateTime? transactionCreatedAt;
  @JsonKey(name: Params.transactionUpdatedAt)
  DateTime? transactionUpdatedAt;
  String? leaf;
  String? currency;
  @JsonKey(name: Params.createdAt)
  DateTime? createdAt;
  @JsonKey(name: Params.updatedAt)
  DateTime? updatedAt;
  String? status;
  @JsonKey(name: Params.statusCode, fromJson: JsonUtils.intFromJson)//toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  int? statusCode;
  @JsonKey(name: Params.statusDenom)
  String? statusDenom;
  String? description;
  @JsonKey(name: Params.invoiceNumber, fromJson: JsonUtils.intFromJson)//toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  int? invoiceNumber;
  /// This is a number to identify the operation by a merchant.
  /// Useful for merchant business logic implementation to identify payments
  /// It must have exactly 12 digits
  @JsonKey(name: "merchant_op_id")
  String? merchantOpId;
  @JsonKey(name: "terminal_id")
  String? terminalId;
  PaymentAmount? amount;
  List<PaymentItem>? items;
  List<PaymentLink>? links;
  @JsonKey(toJson: JsonUtils.doubleToJsonString2Digits, fromJson: JsonUtils.doubleFromJson)//toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
  double? commission;
  @JsonKey(name: Params.buyerIdentityCode)
  String? buyerIdentityCode;
  @JsonKey(name: Params.merchantUUID)
  String? merchantUUID;
  @JsonKey(name: Params.merchantName)
  String? merchantName;
  @JsonKey(name: Params.merchantAlias)
  String? merchantAlias;
  @JsonKey(name: Params.merchantAvatar)
  String? merchantAvatar;
  @JsonKey(name: Params.refundedAmount)
  String? refundedAmount;
  String? username;
  String? name;
  String? lastname;
  String? avatar;
  @JsonKey(name: Params.returnUrl)
  String? returnUrl;
  @JsonKey(name: Params.cancelUrl)
  String? cancelUrl;

  @JsonKey(ignore: true)
  String? _confirmationUrl;

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
    this.avatar,
    this.returnUrl,
    this.cancelUrl,
  });

  String? get confirmationUrl {
    if(_confirmationUrl == null && links != null) {
      for(var link in links!) {
        if(link.isConfirm) {
          _confirmationUrl = link.url;
          break;
        }
      }
    }
    return _confirmationUrl;
  }

  @override
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
  @override
  Payment? fromJsonMap(Map<String, dynamic>? json) => json != null ? Payment.fromJson(json) : null;
  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
