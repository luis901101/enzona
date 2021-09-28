
import 'package:enzona/src/utils/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_link.g.dart';

@JsonSerializable(includeIfNull: false)
class PaymentLink extends Jsonable<PaymentLink>{
	String? rel;
	String? method;
	String? href;

	@override
	PaymentLink({this.rel, this.method, this.href});
	@override
	PaymentLink? fromJsonMap(Map<String, dynamic>? json) => json != null ? PaymentLink.fromJson(json) : null;
	Map<String, dynamic> toJson() => _$PaymentLinkToJson(this);
	factory PaymentLink.fromJson(Map<String, dynamic> json) => _$PaymentLinkFromJson(json);
}
