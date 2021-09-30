
import 'package:enzona/src/utils/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_link.g.dart';

@JsonSerializable(includeIfNull: false)
class PaymentLink extends Jsonable<PaymentLink>{
	String? rel;
	String? method;
	String? href;

	PaymentLink({this.rel, this.method, this.href});

	@override
	Map<String, dynamic> toJson() => _$PaymentLinkToJson(this);
	@override
	PaymentLink? fromJsonMap(Map<String, dynamic>? json) => json != null ? PaymentLink.fromJson(json) : null;
	factory PaymentLink.fromJson(Map<String, dynamic> json) => _$PaymentLinkFromJson(json);
}
