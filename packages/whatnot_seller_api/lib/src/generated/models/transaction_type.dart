// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: TransactionType
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
/// The public, user-facing transaction type values.
enum TransactionType {
  buyItNow("buy_it_now"),
  auction("auction"),
  giveaway("giveaway");

  final String value;
  const TransactionType(this.value);

  factory TransactionType.fromJson(dynamic json) {
    return TransactionType.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => TransactionType.buyItNow,
    );
  }

  String toJson() => value;
}
