
class JsonUtils {
  static String? toJsonString(dynamic value) => value?.toString();
  static int? intFromJson(dynamic json) => int.tryParse(json ?? '');
  static double? doubleFromJson(dynamic json) => double.tryParse(json ?? '');
  static num? numFromJson(dynamic json) => num.tryParse(json ?? '');
  static String? stringFromJson(dynamic json) => json?.toString();
}