// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: VariantPricingInput
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "variant_buy_it_now_input.dart" as _i1;
import "variant_auction_input.dart" as _i2;

/// Prices to stage per format. An omitted format is left unchanged.
class VariantPricingInput(
  final _i1.VariantBuyItNowInput? buyItNow,
  final _i2.VariantAuctionInput? auction,
) {
  factory VariantPricingInput.fromJson(Map<String, dynamic> json) =>
      VariantPricingInput(
        json["buy_it_now"] != null
            ? _i1.VariantBuyItNowInput.fromJson(
                json["buy_it_now"] as Map<String, dynamic>,
              )
            : null,
        json["auction"] != null
            ? _i2.VariantAuctionInput.fromJson(
                json["auction"] as Map<String, dynamic>,
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
    if (buyItNow != null) "buy_it_now": buyItNow?.toJson(),
    if (auction != null) "auction": auction?.toJson(),
  };
}
