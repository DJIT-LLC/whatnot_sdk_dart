// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: OrderStatus
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum OrderStatus {
  pending("pending"),
  pendingFulfillment("pending_fulfillment"),
  completed("completed"),
  cancelled("cancelled"),
  failed("failed");

  final String value;
  const OrderStatus(this.value);

  factory OrderStatus.fromJson(dynamic json) {
    return OrderStatus.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => OrderStatus.pending,
    );
  }

  String toJson() => value;
}
