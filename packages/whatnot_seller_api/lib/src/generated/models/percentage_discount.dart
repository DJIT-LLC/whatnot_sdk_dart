// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: PercentageDiscount
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "money.dart" as _i1;

class PercentageDiscount(
  /// A percentage off the order.
  final String type,

  /// The amount discounted.
  final _i1.Money amount,
) {
  factory PercentageDiscount.fromJson(Map<String, dynamic> json) =>
      PercentageDiscount(
        json["type"] as String,
        _i1.Money.fromJson(json["amount"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {"type": type, "amount": amount.toJson()};
}
