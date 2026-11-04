// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: FixedPriceDiscount
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "money.dart" as _i1;

class FixedPriceDiscount(
  /// A fixed amount off the order.
  final String type,

  /// The amount discounted.
  final _i1.Money amount,
) {
  factory FixedPriceDiscount.fromJson(Map<String, dynamic> json) =>
      FixedPriceDiscount(
        json["type"] as String,
        _i1.Money.fromJson(json["amount"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {"type": type, "amount": amount.toJson()};
}
