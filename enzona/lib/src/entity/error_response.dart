import 'package:enzona/src/utils/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse extends Jsonable<ErrorResponse> {

  int? code;
  String? message;

  ErrorResponse({this.code, this.message, });

  @override
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
  @override
  ErrorResponse? fromJsonMap(Map<String, dynamic>? json) => json != null ? ErrorResponse.fromJson(json) : null;
  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
}