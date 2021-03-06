
class JsonUtils {
  static String? toJsonString(dynamic value) => value?.toString();
  static String? doubleToJsonString2Digits(double? value) => value?.toStringAsFixed(2); //This toJson workaround is necessary because ENZONA API requires all the double values to be exactly 2 decimal digits

  static int? intFromJson(dynamic json) => int.tryParse(json?.toString() ?? ''); //This fromJson implementations here is necessary due to a bad field type declaration on ENZONA API
  static double? doubleFromJson(dynamic json) => double.tryParse(json?.toString() ?? ''); //This fromJson implementations here is necessary due to a bad field type declaration on ENZONA API
  static num? numFromJson(dynamic json) => num.tryParse(json?.toString() ?? ''); //This fromJson implementations here is necessary due to a bad field type declaration on ENZONA API
  static String? stringFromJson(dynamic json) => json?.toString();
}