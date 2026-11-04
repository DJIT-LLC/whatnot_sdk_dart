// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: Money
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class Money(
  /// Decimal amount in major currency units, e.g. 42.00.
  final String amount,

  /// ISO 4217 currency code.
  final String currency,
) {
  factory Money.fromJson(Map<String, dynamic> json) =>
      Money(json["amount"] as String, json["currency"] as String);

  Map<String, dynamic> toJson() => {"amount": amount, "currency": currency};
}
