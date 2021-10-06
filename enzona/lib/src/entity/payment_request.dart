import 'package:enzona/src/entity/payment.dart';
import 'package:enzona/src/entity/payment_amount.dart';
import 'package:enzona/src/entity/payment_item.dart';
import 'package:enzona/src/entity/payment_link.dart';
import 'package:enzona/src/utils/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:enzona/src/utils/json_utils.dart';

part 'payment_request.g.dart';

@JsonSerializable(includeIfNull: false)
class PaymentRequest extends Payment {
  @JsonKey(name: "return_url")
  String returnUrl;
  @JsonKey(name: "cancel_url")
  String cancelUrl;

  PaymentRequest({
    required this.returnUrl,
    required this.cancelUrl,
    String? merchantOpId,
    required String currency,
    required PaymentAmount amount,
    List<PaymentItem>? items,
    String? description,
  }) : super(
    description: description,
    currency: currency,
    amount: amount,
    items: items,
    merchantOpId: merchantOpId,
  );

  @override
  Map<String, dynamic> toJson() => _$PaymentRequestToJson(this);
  @override
  PaymentRequest? fromJsonMap(Map<String, dynamic>? json) => json != null ? PaymentRequest.fromJson(json) : null;
  @override
  List<PaymentRequest>? fromJsonList(List<dynamic>? jsonList) => Jsonable.fromJsonListGeneric<PaymentRequest>(jsonList, fromJsonMap);
  @override
  List<PaymentRequest>? fromJsonStringList(String? jsonStringList) => Jsonable.fromJsonStringListGeneric<PaymentRequest>(jsonStringList, fromJsonMap);
  factory PaymentRequest.fromJson(Map<String, dynamic> json) => _$PaymentRequestFromJson(json);
}
