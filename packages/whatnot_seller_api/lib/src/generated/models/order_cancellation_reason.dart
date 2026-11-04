// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: OrderCancellationReason
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum OrderCancellationReason {
  itemDamaged("item_damaged"),
  itemSold("item_sold"),
  itemMissing("item_missing"),
  breakDidNotFill("break_did_not_fill"),
  other("other");

  final String value;
  const OrderCancellationReason(this.value);

  factory OrderCancellationReason.fromJson(dynamic json) {
    return OrderCancellationReason.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => OrderCancellationReason.itemDamaged,
    );
  }

  String toJson() => value;
}
