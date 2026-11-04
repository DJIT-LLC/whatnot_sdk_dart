// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: VariantAuctionInput
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "money.dart" as _i1;

class VariantAuctionInput(
  /// Auction start price, in whole currency units.
  final _i1.Money startPrice,
) {
  factory VariantAuctionInput.fromJson(Map<String, dynamic> json) =>
      VariantAuctionInput(
        _i1.Money.fromJson(json["start_price"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {"start_price": startPrice.toJson()};
}
