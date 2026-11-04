// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: MerchandiseProductRequest
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "merchandising_transaction_type.dart" as _i1;
import "shows_input.dart" as _i2;

/// Merchandising changes to apply to a product in a single call.  Every field is optional; an omitted field leaves that facet unchanged. The changes are applied together: transaction type first, then show membership, then profile-shop publication.
class MerchandiseProductRequest(
  /// The product's sale format. When provided, overwrites the format on the product. Auctions are always reserved for live and are sold only in shows; add the product to one with shows, in this call or a later one, or it is not purchasable anywhere.
  final _i1.MerchandisingTransactionType? transactionType,

  /// Whether the product is held for live shows only. Auctions are always reserved for live, so this is rejected as false when transaction_type is auction in the same request, and ignored for a product that is already an auction. A buy-it-now product is purchasable on the seller's profile shop only when this is not true. When omitted, the product's current choice is kept. A draft buy-it-now product with no choice yet is treated as false when transaction_type is set, which publishes it to the profile shop. Switching to auction records the product as reserved for live, so switching back to buy-it-now keeps it off the profile shop until this is sent as false.
  final bool? reserveForLive,

  /// The change to which shows the product appears in. Adding a product to a show that is not among the seller's next upcoming shows is applied in the background. Omit to leave the product's shows unchanged.
  final _i2.ShowsInput? shows,
) {
  factory MerchandiseProductRequest.fromJson(Map<String, dynamic> json) =>
      MerchandiseProductRequest(
        json["transaction_type"] != null
            ? _i1.MerchandisingTransactionType.fromJson(
                json["transaction_type"],
              )
            : null,
        json["reserve_for_live"] as bool?,
        json["shows"] != null
            ? _i2.ShowsInput.fromJson(json["shows"] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
    if (transactionType != null) "transaction_type": transactionType?.toJson(),
    if (reserveForLive != null) "reserve_for_live": reserveForLive,
    if (shows != null) "shows": shows?.toJson(),
  };
}
