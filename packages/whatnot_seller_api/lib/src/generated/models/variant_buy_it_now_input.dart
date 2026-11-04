// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: VariantBuyItNowInput
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "money.dart" as _i1;

class VariantBuyItNowInput(
  /// Buy-it-now price, in whole currency units.
  final _i1.Money price,
) {
  factory VariantBuyItNowInput.fromJson(Map<String, dynamic> json) =>
      VariantBuyItNowInput(
        _i1.Money.fromJson(json["price"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {"price": price.toJson()};
}
