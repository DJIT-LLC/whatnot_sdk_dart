import "dart:async";
import "dart:convert";

import "webhook_event.dart";
import "webhook_payloads.dart";
import "webhook_verifier.dart";

/// Type-safe webhook dispatcher for receiving, verifying, and routing Whatnot webhook events.
class WhatnotWebhookDispatcher(
  /// The secret key configured for the webhook endpoint.
  final String secret,
) {
  late final WhatnotWebhookVerifier _verifier = WhatnotWebhookVerifier(secret);

  final List<FutureOr<void> Function(WebhookEvent<OrderWebhookPayload>)>
  _orderCreatedListeners = [];
  final List<FutureOr<void> Function(WebhookEvent<OrderWebhookPayload>)>
  _orderUpdatedListeners = [];
  final List<FutureOr<void> Function(WebhookEvent<ProductSoldPayload>)>
  _productSoldListeners = [];
  final List<FutureOr<void> Function(WebhookEvent<ListingWebhookPayload>)>
  _listingCreatedListeners = [];
  final List<FutureOr<void> Function(WebhookEvent<ListingWebhookPayload>)>
  _listingUpdatedListeners = [];
  final List<FutureOr<void> Function(WebhookEvent<LivestreamWebhookPayload>)>
  _livestreamCreatedListeners = [];
  final List<FutureOr<void> Function(WebhookEvent<LivestreamWebhookPayload>)>
  _livestreamStoppedListeners = [];
  final List<FutureOr<void> Function(WebhookEvent<LivestreamProductPayload>)>
  _livestreamProductAddedListeners = [];
  final List<FutureOr<void> Function(WebhookEvent<LivestreamProductPayload>)>
  _livestreamProductRemovedListeners = [];
  final List<FutureOr<void> Function(WebhookEvent<ShipmentLabelPayload>)>
  _shipmentLabelCreatedListeners = [];
  final List<FutureOr<void> Function(WebhookEvent<BulkOperationPayload>)>
  _bulkOperationFinishedListeners = [];
  final List<FutureOr<void> Function(WebhookEvent<dynamic>)>
  _anyEventListeners = [];

  /// Registers a listener for `order/created` events.
  void onOrderCreated(
    FutureOr<void> Function(WebhookEvent<OrderWebhookPayload> event) handler,
  ) {
    _orderCreatedListeners.add(handler);
  }

  /// Registers a listener for `order/updated` events.
  void onOrderUpdated(
    FutureOr<void> Function(WebhookEvent<OrderWebhookPayload> event) handler,
  ) {
    _orderUpdatedListeners.add(handler);
  }

  /// Registers a listener for `product/sold` events.
  void onProductSold(
    FutureOr<void> Function(WebhookEvent<ProductSoldPayload> event) handler,
  ) {
    _productSoldListeners.add(handler);
  }

  /// Registers a listener for `listing/created` events.
  void onListingCreated(
    FutureOr<void> Function(WebhookEvent<ListingWebhookPayload> event) handler,
  ) {
    _listingCreatedListeners.add(handler);
  }

  /// Registers a listener for `listing/updated` events.
  void onListingUpdated(
    FutureOr<void> Function(WebhookEvent<ListingWebhookPayload> event) handler,
  ) {
    _listingUpdatedListeners.add(handler);
  }

  /// Registers a listener for `livestream/created` events.
  void onLivestreamCreated(
    FutureOr<void> Function(WebhookEvent<LivestreamWebhookPayload> event)
    handler,
  ) {
    _livestreamCreatedListeners.add(handler);
  }

  /// Registers a listener for `livestream/stopped` events.
  void onLivestreamStopped(
    FutureOr<void> Function(WebhookEvent<LivestreamWebhookPayload> event)
    handler,
  ) {
    _livestreamStoppedListeners.add(handler);
  }

  /// Registers a listener for `livestream/product/added` events.
  void onLivestreamProductAdded(
    FutureOr<void> Function(WebhookEvent<LivestreamProductPayload> event)
    handler,
  ) {
    _livestreamProductAddedListeners.add(handler);
  }

  /// Registers a listener for `livestream/product/removed` events.
  void onLivestreamProductRemoved(
    FutureOr<void> Function(WebhookEvent<LivestreamProductPayload> event)
    handler,
  ) {
    _livestreamProductRemovedListeners.add(handler);
  }

  /// Registers a listener for `shipment/label/created` events.
  void onShipmentLabelCreated(
    FutureOr<void> Function(WebhookEvent<ShipmentLabelPayload> event) handler,
  ) {
    _shipmentLabelCreatedListeners.add(handler);
  }

  /// Registers a listener for `bulk_operation/finished` events.
  void onBulkOperationFinished(
    FutureOr<void> Function(WebhookEvent<BulkOperationPayload> event) handler,
  ) {
    _bulkOperationFinishedListeners.add(handler);
  }

  /// Registers a fallback listener for all events regardless of topic.
  void onAnyEvent(
    FutureOr<void> Function(WebhookEvent<dynamic> event) handler,
  ) {
    _anyEventListeners.add(handler);
  }

  /// Verifies the [signatureHeader] and dispatches the raw webhook request to registered listeners.
  Future<void> handleRequest({
    required List<int> rawBodyBytes,
    required String? signatureHeader,
  }) async {
    _verifier.verifyOrThrow(
      rawBodyBytes: rawBodyBytes,
      signature: signatureHeader,
    );

    final rawString = utf8.decode(rawBodyBytes);
    final dynamic decoded = jsonDecode(rawString);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException("Expected JSON object in webhook body");
    }

    final topic = decoded["topic"] as String? ?? "";

    // Route to topic listeners
    switch (topic) {
      case "order/created":
        final event = WebhookEvent<OrderWebhookPayload>.fromJson(
          decoded,
          OrderWebhookPayload.fromJson,
        );
        for (final listener in _orderCreatedListeners) {
          await listener(event);
        }
      case "order/updated":
        final event = WebhookEvent<OrderWebhookPayload>.fromJson(
          decoded,
          OrderWebhookPayload.fromJson,
        );
        for (final listener in _orderUpdatedListeners) {
          await listener(event);
        }
      case "product/sold":
        final event = WebhookEvent<ProductSoldPayload>.fromJson(
          decoded,
          ProductSoldPayload.fromJson,
        );
        for (final listener in _productSoldListeners) {
          await listener(event);
        }
      case "listing/created":
        final event = WebhookEvent<ListingWebhookPayload>.fromJson(
          decoded,
          ListingWebhookPayload.fromJson,
        );
        for (final listener in _listingCreatedListeners) {
          await listener(event);
        }
      case "listing/updated":
        final event = WebhookEvent<ListingWebhookPayload>.fromJson(
          decoded,
          ListingWebhookPayload.fromJson,
        );
        for (final listener in _listingUpdatedListeners) {
          await listener(event);
        }
      case "livestream/created":
        final event = WebhookEvent<LivestreamWebhookPayload>.fromJson(
          decoded,
          LivestreamWebhookPayload.fromJson,
        );
        for (final listener in _livestreamCreatedListeners) {
          await listener(event);
        }
      case "livestream/stopped":
        final event = WebhookEvent<LivestreamWebhookPayload>.fromJson(
          decoded,
          LivestreamWebhookPayload.fromJson,
        );
        for (final listener in _livestreamStoppedListeners) {
          await listener(event);
        }
      case "livestream/product/added":
        final event = WebhookEvent<LivestreamProductPayload>.fromJson(
          decoded,
          LivestreamProductPayload.fromJson,
        );
        for (final listener in _livestreamProductAddedListeners) {
          await listener(event);
        }
      case "livestream/product/removed":
        final event = WebhookEvent<LivestreamProductPayload>.fromJson(
          decoded,
          LivestreamProductPayload.fromJson,
        );
        for (final listener in _livestreamProductRemovedListeners) {
          await listener(event);
        }
      case "shipment/label/created":
        final event = WebhookEvent<ShipmentLabelPayload>.fromJson(
          decoded,
          ShipmentLabelPayload.fromJson,
        );
        for (final listener in _shipmentLabelCreatedListeners) {
          await listener(event);
        }
      case "bulk_operation/finished":
        final event = WebhookEvent<BulkOperationPayload>.fromJson(
          decoded,
          BulkOperationPayload.fromJson,
        );
        for (final listener in _bulkOperationFinishedListeners) {
          await listener(event);
        }
    }

    // Call generic listeners
    if (_anyEventListeners.isNotEmpty) {
      final genericEvent = WebhookEvent<dynamic>.fromJson(decoded, (o) => o);
      for (final listener in _anyEventListeners) {
        await listener(genericEvent);
      }
    }
  }
}
