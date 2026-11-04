// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: OrderItem
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "purchased_item.dart" as _i1;
import "money.dart" as _i2;

class OrderItem(
  /// The order item's ID.
  final String id,

  /// The ID of the order containing this item.
  final String orderId,

  /// The purchased product's ID, if known.
  final String? productId,

  /// The purchased variant's ID, if the product has variants.
  final String? variantId,

  /// The seller-provided external ID of the purchased product, if set.
  final String? productExternalId,

  /// The seller-provided external ID of the purchased variant, if set.
  final String? variantExternalId,

  /// The item as listed when it was purchased, if recorded.
  final _i1.PurchasedItem? purchasedItem,

  /// The number of units purchased.
  final int quantity,

  /// The price of one unit.
  final _i2.Money unitPrice,

  /// Whether unit_price includes tax, if recorded.
  final bool? priceIncludesTax,

  /// The ID of the shipment currently containing this item, if any.
  final String? shipmentId,
) {
  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    json["id"] as String,
    json["order_id"] as String,
    json["product_id"] as String?,
    json["variant_id"] as String?,
    json["product_external_id"] as String?,
    json["variant_external_id"] as String?,
    json["purchased_item"] != null
        ? _i1.PurchasedItem.fromJson(
            json["purchased_item"] as Map<String, dynamic>,
          )
        : null,
    json["quantity"] as int,
    _i2.Money.fromJson(json["unit_price"] as Map<String, dynamic>),
    json["price_includes_tax"] as bool?,
    json["shipment_id"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    if (productId != null) "product_id": productId,
    if (variantId != null) "variant_id": variantId,
    if (productExternalId != null) "product_external_id": productExternalId,
    if (variantExternalId != null) "variant_external_id": variantExternalId,
    if (purchasedItem != null) "purchased_item": purchasedItem?.toJson(),
    "quantity": quantity,
    "unit_price": unitPrice.toJson(),
    if (priceIncludesTax != null) "price_includes_tax": priceIncludesTax,
    if (shipmentId != null) "shipment_id": shipmentId,
  };
}
