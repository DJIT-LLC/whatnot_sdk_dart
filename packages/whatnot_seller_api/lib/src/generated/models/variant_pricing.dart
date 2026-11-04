// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: VariantPricing
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "variant_buy_it_now.dart" as _i1;
import "variant_auction.dart" as _i2;

class VariantPricing(
  final _i1.VariantBuyItNow buyItNow,
  final _i2.VariantAuction auction,
) {
  factory VariantPricing.fromJson(Map<String, dynamic> json) => VariantPricing(
    _i1.VariantBuyItNow.fromJson(json["buy_it_now"] as Map<String, dynamic>),
    _i2.VariantAuction.fromJson(json["auction"] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "buy_it_now": buyItNow.toJson(),
    "auction": auction.toJson(),
  };
}
