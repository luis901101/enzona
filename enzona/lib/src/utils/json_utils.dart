
class JsonUtils {
  static String? toJsonString(dynamic value) => value?.toString();
  static int? intFromJsonString(dynamic json) => int.tryParse(json ?? '');
  static double? doubleFromJsonString(dynamic json) => double.tryParse(json ?? '');
  static num? numFromJsonString(dynamic json) => num.tryParse(json ?? '');
}