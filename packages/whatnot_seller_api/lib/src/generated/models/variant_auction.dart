// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: VariantAuction
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "money.dart" as _i1;

class VariantAuction(
  /// Auction start price.
  final _i1.Money? startPrice,
) {
  factory VariantAuction.fromJson(Map<String, dynamic> json) => VariantAuction(
    json["start_price"] != null
        ? _i1.Money.fromJson(json["start_price"] as Map<String, dynamic>)
        : null,
  );

  Map<String, dynamic> toJson() => {
    if (startPrice != null) "start_price": startPrice?.toJson(),
  };
}
