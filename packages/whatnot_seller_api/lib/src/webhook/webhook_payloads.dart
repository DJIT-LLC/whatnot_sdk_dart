/// Payload for `order/created` and `order/updated` webhook topics.
class OrderWebhookPayload(
  /// The Whatnot order ID.
  final String orderId,

  /// The order status.
  final String status, {

  /// Numeric order number if provided.
  final String? orderNumber,

  /// Order total in cents.
  final int? totalCents,

  /// Shipping price in cents.
  final int? shippingPriceCents,

  /// Destination shipping address.
  final Map<String, dynamic>? shippingAddress,

  /// Line items included in the order.
  final List<Map<String, dynamic>> items = const [],

  /// Cancellation timestamp if cancelled.
  final DateTime? cancelledAt,

  /// Raw payload object.
  final Map<String, dynamic> raw = const {},
}) {
  factory OrderWebhookPayload.fromJson(dynamic raw) {
    if (raw is! Map<String, dynamic>) {
      return OrderWebhookPayload(raw.toString(), "unknown");
    }
    return OrderWebhookPayload(
      (raw["order_id"] ?? raw["id"] ?? "").toString(),
      (raw["status"] ?? "unknown").toString(),
      orderNumber: raw["order_number"]?.toString(),
      totalCents: (raw["total"] as num?)?.toInt(),
      shippingPriceCents: (raw["shipping_price"] as num?)?.toInt(),
      shippingAddress: raw["shipping_address"] as Map<String, dynamic>?,
      items:
          (raw["items"] as List<dynamic>?)
              ?.whereType<Map<String, dynamic>>()
              .toList() ??
          const [],
      cancelledAt: raw["cancelled_at"] != null
          ? DateTime.tryParse(raw["cancelled_at"].toString())
          : null,
      raw: raw,
    );
  }
}

/// Payload for `product/sold` webhook topics.
class ProductSoldPayload(
  /// The ID of the sold product.
  final String productId,

  /// Quantity of items sold.
  final int quantity, {

  /// Variant ID if applicable.
  final String? variantId,

  /// Associated order ID.
  final String? orderId,

  /// Sold price in cents.
  final int? priceCents,

  /// Raw payload object.
  final Map<String, dynamic> raw = const {},
}) {
  factory ProductSoldPayload.fromJson(dynamic raw) {
    if (raw is! Map<String, dynamic>) {
      return ProductSoldPayload(raw.toString(), 1);
    }
    return ProductSoldPayload(
      (raw["product_id"] ?? raw["id"] ?? "").toString(),
      (raw["quantity"] as num?)?.toInt() ?? 1,
      variantId: raw["variant_id"]?.toString(),
      orderId: raw["order_id"]?.toString(),
      priceCents: (raw["price"] as num?)?.toInt(),
      raw: raw,
    );
  }
}

/// Payload for `listing/created` and `listing/updated` webhook topics.
class ListingWebhookPayload(
  /// The ID of the product listing.
  final String productId,

  /// Title of the listing.
  final String title, {

  /// Available quantity.
  final int? quantity,

  /// Price in cents.
  final int? priceCents,

  /// Listing status.
  final String? status,

  /// Raw payload object.
  final Map<String, dynamic> raw = const {},
}) {
  factory ListingWebhookPayload.fromJson(dynamic raw) {
    if (raw is! Map<String, dynamic>) {
      return ListingWebhookPayload(raw.toString(), "");
    }
    return ListingWebhookPayload(
      (raw["product_id"] ?? raw["id"] ?? "").toString(),
      (raw["title"] ?? "").toString(),
      quantity: (raw["quantity"] as num?)?.toInt(),
      priceCents: (raw["price"] as num?)?.toInt(),
      status: raw["status"]?.toString(),
      raw: raw,
    );
  }
}

/// Payload for `livestream/created` and `livestream/stopped` webhook topics.
class LivestreamWebhookPayload(
  /// The ID of the livestream show.
  final String livestreamId, {

  /// The title of the livestream show.
  final String? title,

  /// Current show status.
  final String? status,

  /// Raw payload object.
  final Map<String, dynamic> raw = const {},
}) {
  factory LivestreamWebhookPayload.fromJson(dynamic raw) {
    if (raw is! Map<String, dynamic>) {
      return LivestreamWebhookPayload(raw.toString());
    }
    return LivestreamWebhookPayload(
      (raw["livestream_id"] ?? raw["id"] ?? "").toString(),
      title: raw["title"]?.toString(),
      status: raw["status"]?.toString(),
      raw: raw,
    );
  }
}

/// Payload for `livestream/product/added` and `livestream/product/removed` webhook topics.
class LivestreamProductPayload(
  /// The ID of the livestream show.
  final String livestreamId,

  /// The ID of the product.
  final String productId, {

  /// Raw payload object.
  final Map<String, dynamic> raw = const {},
}) {
  factory LivestreamProductPayload.fromJson(dynamic raw) {
    if (raw is! Map<String, dynamic>) {
      return LivestreamProductPayload(raw.toString(), "");
    }
    return LivestreamProductPayload(
      (raw["livestream_id"] ?? raw["show_id"] ?? "").toString(),
      (raw["product_id"] ?? raw["id"] ?? "").toString(),
      raw: raw,
    );
  }
}

/// Payload for `shipment/label/created` webhook topics.
class ShipmentLabelPayload(
  /// The ID of the shipment.
  final String shipmentId, {

  /// Tracking number or code.
  final String? trackingCode,

  /// Shipping carrier (e.g. USPS, UPS).
  final String? carrier,

  /// Download URL for the shipping label.
  final String? labelUrl,

  /// Raw payload object.
  final Map<String, dynamic> raw = const {},
}) {
  factory ShipmentLabelPayload.fromJson(dynamic raw) {
    if (raw is! Map<String, dynamic>) {
      return ShipmentLabelPayload(raw.toString());
    }
    return ShipmentLabelPayload(
      (raw["shipment_id"] ?? raw["id"] ?? "").toString(),
      trackingCode: raw["tracking_code"]?.toString(),
      carrier: raw["carrier"]?.toString(),
      labelUrl: raw["label_url"]?.toString(),
      raw: raw,
    );
  }
}

/// Payload for `bulk_operation/finished` webhook topics.
class BulkOperationPayload(
  /// The ID of the bulk operation.
  final String operationId,

  /// Result status of the bulk operation.
  final String status, {

  /// Number of failed records if any.
  final int? errorCount,

  /// Raw payload object.
  final Map<String, dynamic> raw = const {},
}) {
  factory BulkOperationPayload.fromJson(dynamic raw) {
    if (raw is! Map<String, dynamic>) {
      return BulkOperationPayload(raw.toString(), "unknown");
    }
    return BulkOperationPayload(
      (raw["operation_id"] ?? raw["id"] ?? "").toString(),
      (raw["status"] ?? "unknown").toString(),
      errorCount: (raw["error_count"] as num?)?.toInt(),
      raw: raw,
    );
  }
}
