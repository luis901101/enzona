
import 'package:enzona/src/utils/json_utils.dart';
import 'package:enzona/src/utils/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable(includeIfNull: false)
class Pagination<T extends Jsonable> extends Jsonable<Pagination>{

	static const String paginationParam = 'pagination';
	static const String totalCountHeader = 'X-Total-Count';

	String? first;
	String? prev;
	String? next;
	String? last;
	@JsonKey(fromJson: JsonUtils.intFromJson) //toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
	int? total;
	@JsonKey(name: 'total_amount', toJson: JsonUtils.doubleToJsonString2Digits, fromJson: JsonUtils.doubleFromJson)//toJson and fromJson implementations here are necessary due to a bad field type declaration on ENZONA API
	double? totalAmount;

	Pagination({
		this.first,
		this.prev,
		this.next,
		this.last,
		this.total,
		this.totalAmount
	});

  @override
	Map<String, dynamic> toJson() => _$PaginationToJson(this);
	@override
	Pagination? fromJsonMap(Map<String, dynamic>? json) => json != null ? Pagination.fromJson(json) : null;
	factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
}
