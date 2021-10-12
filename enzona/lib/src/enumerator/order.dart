class Order {
  final String value;
  const Order._(this.value);
  static Order get asc => Order._('asc');
  static Order get desc => Order._('desc');
  @override
  String toString() => value;
  String toJson() => toString();
  factory Order.fromJson(dynamic json) =>
      json?.toString().toLowerCase() == 'desc' ? desc : asc;
}

// Enums are not well parsed by Chopper when using it on query
// enum Order {
//   asc,
//   desc,
// }
//
// extension OrderExtension on Order {
//   String get name {
//     final String fullString = toString();
//     final int indexOfDot = fullString.indexOf('.');
//     return fullString.substring(indexOfDot + 1);
//   }
//   String toJson() => name;
// }
