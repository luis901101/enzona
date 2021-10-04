
class JsonUtils {
  static String? toJsonString(dynamic value) => value?.toString();
  static int? intFromJson(dynamic json) => int.tryParse(json?.toString() ?? '');
  static double? doubleFromJson(dynamic json) => double.tryParse(json?.toString() ?? '');
  static num? numFromJson(dynamic json) => num.tryParse(json?.toString() ?? '');
  static String? stringFromJson(dynamic json) => json?.toString();
}