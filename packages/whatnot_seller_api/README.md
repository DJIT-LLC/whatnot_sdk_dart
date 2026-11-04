# whatnot_seller_api

A modern Dart SDK for interacting with the official **Whatnot Seller REST v2 API** and receiving, verifying, and dispatching **Whatnot Webhooks**.

Generated directly from Whatnot's official OpenAPI 3.1.0 specification using `analyzer_buffer` and built with **Dart 3.13+ Primary Constructors**.

---

## Features

* **Official OpenAPI 3.1.0 Parity**: Generated directly from Whatnot's live OpenAPI spec (`https://developers.whatnot.com/api-reference/openapi.json`).
* **Complete REST v2 Resources**:
  * **Products**: Full catalog management, variants, batches, media, options, attributes.
  * **Orders**: Order retrieval, cancellation, line items, filtering, and pagination.
  * **Inventory**: Batch adjustments, absolute stock level synchronization.
  * **Shipments & Shipping**: Shipments, line items, shipping label generation, tracking codes, dimension profiles.
  * **Merchandising**: Product merchandising (Auction vs. Buy It Now), show lineups.
  * **Shows & Livestreams**: Scheduled, live, and past shows.
  * **Analytics**: Real-time livestream and show metrics.
  * **Reports**: Financial, analytics overview, and livestream statements.
  * **Users**: Seller profile details and app authorization revocation.
* **Resilient HTTP Client**:
  * Automatic Bearer token authentication injection.
  * RFC 9457 Problem Details error translation (`application/problem+json`).
  * Rate-limit tracking (`RateLimit-Limit`, `RateLimit-Remaining`, `RateLimit-Reset`).
  * Automatic exponential backoff and retry handling respecting Whatnot's `Retry-After` header.
* **Cryptographic Webhook Engine**:
  * HMAC-SHA256 signature verification (`X-Whatnot-Webhook-Signature`) with constant-time equality check to prevent timing attacks.
  * Typed webhook envelope (`WebhookEvent<T>`) and topic dispatcher (`order/created`, `product/sold`, etc.).
* **Automated Spec Tracking & Code Generation**:
  * Track when Whatnot updates their OpenAPI spec via `tool/update_spec.dart`.
  * Pure Dart code generator powered by `analyzer_buffer` via `tool/generate.dart`.

---

## Installation

Add `whatnot_seller_api` to your `pubspec.yaml`:

```yaml
dependencies:
  whatnot_seller_api:
    git:
      url: https://github.com/DJIT-LLC/whatnot_sdk_dart.git
      path: packages/whatnot_seller_api
```

---

## Quickstart

### 1. Initialize the REST Client

```dart
import 'package:whatnot_seller_api/whatnot_seller_api.dart';

void main() async {
  final client = WhatnotSellerClient.withToken('wn_access_tk_your_token_here');

  // Fetch the seller profile
  final me = await client.users.getMe();
  print('Logged in as: ${me.username}');

  // List orders
  final ordersPage = await client.orders.list(limit: 20);
  for (final order in ordersPage.items) {
    print('Order: ${order.id} - Status: ${order.status.value}');
  }

  // Close when done
  client.close();
}
```

### 2. Handling Webhooks with Verification

Whatnot signs incoming webhook POST requests with the `X-Whatnot-Webhook-Signature` header. The SDK provides `WhatnotWebhookDispatcher` for verifying and routing events:

```dart
import 'package:whatnot_seller_api/whatnot_seller_api.dart';

final dispatcher = WhatnotWebhookDispatcher('your_webhook_secret_key');

// Register typed listeners
dispatcher.onOrderCreated((event) {
  print('New order received: ${event.object.orderId}');
  print('Order total: \$${((event.object.totalCents ?? 0) / 100).toStringAsFixed(2)}');
});

dispatcher.onProductSold((event) {
  print('Product sold: ${event.object.productId} (Qty: ${event.object.quantity})');
});

// Inside your HTTP server request handler (Shelf, Dart Frog, or dart:io):
void handleIncomingWebhook(List<int> rawBodyBytes, String? signatureHeader) async {
  try {
    await dispatcher.handleRequest(
      rawBodyBytes: rawBodyBytes,
      signatureHeader: signatureHeader,
    );
  } on WhatnotWebhookSignatureException catch (e) {
    // 401 Unauthorized / Invalid Signature
    print('Invalid webhook signature: $e');
  }
}
```

---

## Updating the OpenAPI Spec

Whatnot occasionally adds new endpoints or updates existing schemas. You can check for updates or regenerate the code at any time using the built-in CLI tools:

```bash
# Check if Whatnot published a new OpenAPI version (exits with code 1 if an update is found)
puro dart run tool/update_spec.dart --check

# Download the latest spec and regenerate SDK code
puro dart run tool/update_spec.dart --update

# Or run the code generator directly
puro dart run tool/generate.dart
```

---

## License

MIT

