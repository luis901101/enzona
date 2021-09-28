import 'package:enzona/src/entity/payment_amount.dart';
import 'package:enzona/src/entity/payment_item.dart';
import 'package:enzona/src/entity/payment_link.dart';
import 'package:enzona/src/utils/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable(includeIfNull: false)
class Payment extends Jsonable<Payment>{
  @JsonKey(name: "transaction_uuid")
  String? transactionUuid;
  @JsonKey(name: "transaction_denom")
  String? transactionDenom;
  String? leaf;
  String? currency;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  String? status;
  @JsonKey(name: "status_code")
  String? statusCode;
  @JsonKey(name: "status_denom")
  String? statusDenom;
  String? description;
  @JsonKey(name: "invoice_number")
  String? invoiceNumber;
  @JsonKey(name: "merchant_op_id")
  String? merchantOpId;
  @JsonKey(name: "terminal_id")
  String? terminalId;
  PaymentAmount? amount;
  List<PaymentItem>? items;
  List<PaymentLink>? links;
  String? commission;
  @JsonKey(name: "return_url")
  String? returUrl;
  @JsonKey(name: "cancel_url")
  String? cancelUrl;
  @JsonKey(name: "buyer_identity_code")
  String? buyerIdentityCode;


  Payment(
      {this.transactionUuid,
      this.transactionDenom,
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
      this.returUrl,
      this.cancelUrl,
      this.buyerIdentityCode});

  @override
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
  @override
  Payment? fromJsonMap(Map<String, dynamic>? json) => json != null ? Payment.fromJson(json) : null;
  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
