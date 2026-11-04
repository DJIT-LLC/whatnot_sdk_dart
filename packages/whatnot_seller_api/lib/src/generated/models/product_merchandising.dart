// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ProductMerchandising
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "transaction_type.dart" as _i1;

/// How and where a product is currently being sold.  The seller-facing merchandising view of a product: its sale format, whether it is reserved for live, and whether it is assigned to any upcoming or live shows. The shows themselves are paginated separately at ``GET /merchandising/products/{product_id}/shows``.
class ProductMerchandising(
  /// The configured sale format; selects which variant pricing is used. Null when the product has no listing.
  final _i1.TransactionType? transactionType,

  /// Whether the product is sold only in live shows. Auctions are always reserved for live. A buy-it-now product that is not reserved for live is listed for sale on the seller's profile shop.
  final bool reservedForLive,

  /// Whether the product is assigned to at least one upcoming or live show. List the shows at GET /merchandising/products/{product_id}/shows.
  final bool activeInShows,
) {
  factory ProductMerchandising.fromJson(Map<String, dynamic> json) =>
      ProductMerchandising(
        json["transaction_type"] != null
            ? _i1.TransactionType.fromJson(json["transaction_type"])
            : null,
        json["reserved_for_live"] as bool,
        json["active_in_shows"] as bool,
      );

  Map<String, dynamic> toJson() => {
    if (transactionType != null) "transaction_type": transactionType?.toJson(),
    "reserved_for_live": reservedForLive,
    "active_in_shows": activeInShows,
  };
}
