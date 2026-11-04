// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: MerchandiseProductResponse
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "transaction_type.dart" as _i1;

/// The outcome of a merchandising call for a product.
class MerchandiseProductResponse(
  /// The product that was merchandised.
  final String productId,

  /// The product's sale format after the call.
  final _i1.TransactionType? transactionType,

  /// Whether the product is sold only in live shows. Auctions are always reserved for live. A buy-it-now product that is not reserved for live is listed for sale on the seller's profile shop.
  final bool reservedForLive,
) {
  factory MerchandiseProductResponse.fromJson(Map<String, dynamic> json) =>
      MerchandiseProductResponse(
        json["product_id"] as String,
        json["transaction_type"] != null
            ? _i1.TransactionType.fromJson(json["transaction_type"])
            : null,
        json["reserved_for_live"] as bool,
      );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    if (transactionType != null) "transaction_type": transactionType?.toJson(),
    "reserved_for_live": reservedForLive,
  };
}
