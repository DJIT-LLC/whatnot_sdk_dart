// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: VariantBuyItNow
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "money.dart" as _i1;

class VariantBuyItNow(
  /// Buy-it-now price.
  final _i1.Money? price,
) {
  factory VariantBuyItNow.fromJson(Map<String, dynamic> json) =>
      VariantBuyItNow(
        json["price"] != null
            ? _i1.Money.fromJson(json["price"] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
    if (price != null) "price": price?.toJson(),
  };
}
