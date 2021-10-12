
extension DateTimeUtils on DateTime {
  String toJson() => toString();
  static DateTime fromJson(dynamic json) => DateTime.parse(json);
}