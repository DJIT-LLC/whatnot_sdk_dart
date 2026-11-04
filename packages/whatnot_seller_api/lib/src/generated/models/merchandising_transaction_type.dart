// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: MerchandisingTransactionType
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
/// The sale formats a merchandising call can set.
enum MerchandisingTransactionType {
  buyItNow("buy_it_now"),
  auction("auction");

  final String value;
  const MerchandisingTransactionType(this.value);

  factory MerchandisingTransactionType.fromJson(dynamic json) {
    return MerchandisingTransactionType.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => MerchandisingTransactionType.buyItNow,
    );
  }

  String toJson() => value;
}
