// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: OrderTransactionType
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum OrderTransactionType {
  buyItNow("buy_it_now"),
  auction("auction"),
  giveaway("giveaway"),
  other("other");

  final String value;
  const OrderTransactionType(this.value);

  factory OrderTransactionType.fromJson(dynamic json) {
    return OrderTransactionType.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => OrderTransactionType.buyItNow,
    );
  }

  String toJson() => value;
}
