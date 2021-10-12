
import 'package:enzona/src/utils/jsonable.dart';
import 'package:enzona/src/utils/params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_link.g.dart';

/// This class is used to represent an action to be taken over a Payment
///  "rel": "confirm", "method": "REDIRECT" ===> The link should be used to confirm a payment by redirecting the client to the href link which is a link to the Enzona platform.
///  "rel": "complete", "method": "POST" ===> The link should be used to complete a payment, instead of using the link on href, a proper POST request should be generated with proper authentication
///  "rel": "cancel", "method": "POST" ===> The link should be used to cancel a payment, instead of using the link on href, a proper POST request should be generated with proper authentication
///  "rel": "refund", "method": "POST" ===> The link should be used to refund a payment, instead of using the link on href, a proper POST request should be generated with proper authentication
///  "rel": "self", "method": "GET" ===> The link should be used to get a payment data, instead of using the link on href, a proper GET request should be generated with proper authentication
@JsonSerializable(includeIfNull: false)
class PaymentLink extends Jsonable<PaymentLink>{
	/// Possible values:
	/// "confirm": Indicates the link should be used to confirm the payment
	/// "complete": Indicates the link should be used to complete the payment
	/// "cancel": Indicates the link should be used to cancel the payment
	/// "refund": Indicates the link should be used to refund the payment
	String? rel;

	/// Possible values:
	/// "REDIRECT": Indicates the link should be used to redirect the client
	/// "POST": Indicates the link should be used to make a POST request
	/// "GET": Indicates the link should be used to make a GET request
	String? method;

	@JsonKey(name: Params.href)
	String? url;

	PaymentLink({this.rel, this.method, this.url});

	bool get isConfirm => rel == 'confirm';
	bool get isComplete => rel == 'complete';
	bool get isCancel => rel == 'cancel';
	bool get isRefund => rel == 'refund';
	bool get isSelf => rel == 'self';

	@override
	Map<String, dynamic> toJson() => _$PaymentLinkToJson(this);
	@override
	PaymentLink? fromJsonMap(Map<String, dynamic>? json) => json != null ? PaymentLink.fromJson(json) : null;
	factory PaymentLink.fromJson(Map<String, dynamic> json) => _$PaymentLinkFromJson(json);
}
