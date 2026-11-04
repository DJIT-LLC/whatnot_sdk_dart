import "dart:convert";

import "package:crypto/crypto.dart";
import "package:whatnot_seller_api/whatnot_seller_api.dart";

void main() async {
  // 1. Initialize the Whatnot Seller Client
  final client = WhatnotSellerClient.withToken("wn_access_tk_sample_token");

  print("Whatnot Seller Client initialized.");
  print("API Base URL: ${client.config.baseUrl}");

  // 2. Setting up the Webhook Dispatcher
  const webhookSecret = "whsec_sample_secret_key_12345";
  final dispatcher = WhatnotWebhookDispatcher(webhookSecret);

  // Register typed event handlers
  dispatcher.onOrderCreated((event) {
    print("\n[Webhook Received] Topic: ${event.topic}");
    print("  Event ID: ${event.id}");
    print("  Order ID: ${event.object.orderId}");
    print("  Status:   ${event.object.status}");
    print(
      "  Total:    \$${((event.object.totalCents ?? 0) / 100).toStringAsFixed(2)}",
    );
  });

  dispatcher.onProductSold((event) {
    print("\n[Webhook Received] Product Sold!");
    print("  Product ID: ${event.object.productId}");
    print("  Quantity:   ${event.object.quantity}");
  });

  // 3. Simulate an incoming Whatnot webhook HTTP request
  final samplePayload = {
    "id": "evt_987654321",
    "timestamp": DateTime.now().toUtc().toIso8601String(),
    "topic": "order/created",
    "object": {
      "order_id": "ord_123456789",
      "order_number": "10042",
      "status": "confirmed",
      "total": 4999,
      "shipping_price": 500,
      "items": [
        {"title": "Vintage Rare Card #1", "quantity": 1, "price": 4499},
      ],
    },
  };

  final rawBodyBytes = utf8.encode(jsonEncode(samplePayload));

  // Compute HMAC-SHA256 signature as Whatnot would
  final hmac = Hmac(sha256, utf8.encode(webhookSecret));
  final signature = hmac.convert(rawBodyBytes).toString();

  print("\nSimulating incoming webhook delivery...");
  print("Signature: $signature");

  // Handle request in dispatcher
  await dispatcher.handleRequest(
    rawBodyBytes: rawBodyBytes,
    signatureHeader: signature,
  );

  client.close();
}
