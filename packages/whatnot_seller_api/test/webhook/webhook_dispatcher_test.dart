import "dart:convert";

import "package:crypto/crypto.dart";
import "package:test/test.dart";
import "package:whatnot_seller_api/whatnot_seller_api.dart";

void main() {
  group("WhatnotWebhookDispatcher", () {
    const secret = "whsec_dispatcher_test";
    late WhatnotWebhookDispatcher dispatcher;

    setUp(() {
      dispatcher = WhatnotWebhookDispatcher(secret);
    });

    String sign(List<int> bytes) {
      final hmac = Hmac(sha256, utf8.encode(secret));
      return hmac.convert(bytes).toString();
    }

    test("routes order/created to onOrderCreated listener", () async {
      WebhookEvent<OrderWebhookPayload>? receivedEvent;
      dispatcher.onOrderCreated((event) {
        receivedEvent = event;
      });

      final payload = {
        "id": "evt_order_1",
        "timestamp": "2026-11-03T18:00:00Z",
        "topic": "order/created",
        "object": {"order_id": "ord_abc", "status": "confirmed", "total": 2500},
      };

      final bodyBytes = utf8.encode(jsonEncode(payload));
      final sig = sign(bodyBytes);

      await dispatcher.handleRequest(
        rawBodyBytes: bodyBytes,
        signatureHeader: sig,
      );

      expect(receivedEvent, isNotNull);
      expect(receivedEvent!.id, equals("evt_order_1"));
      expect(receivedEvent!.topic, equals("order/created"));
      expect(receivedEvent!.object.orderId, equals("ord_abc"));
      expect(receivedEvent!.object.status, equals("confirmed"));
      expect(receivedEvent!.object.totalCents, equals(2500));
    });

    test("routes product/sold to onProductSold listener", () async {
      WebhookEvent<ProductSoldPayload>? receivedEvent;
      dispatcher.onProductSold((event) {
        receivedEvent = event;
      });

      final payload = {
        "id": "evt_sold_1",
        "timestamp": "2026-11-03T18:00:00Z",
        "topic": "product/sold",
        "object": {"product_id": "prod_xyz", "quantity": 3, "price": 1500},
      };

      final bodyBytes = utf8.encode(jsonEncode(payload));
      final sig = sign(bodyBytes);

      await dispatcher.handleRequest(
        rawBodyBytes: bodyBytes,
        signatureHeader: sig,
      );

      expect(receivedEvent, isNotNull);
      expect(receivedEvent!.object.productId, equals("prod_xyz"));
      expect(receivedEvent!.object.quantity, equals(3));
      expect(receivedEvent!.object.priceCents, equals(1500));
    });

    test("invokes onAnyEvent for all received events", () async {
      final events = <WebhookEvent<dynamic>>[];
      dispatcher.onAnyEvent((event) {
        events.add(event);
      });

      final payload = {
        "id": "evt_custom",
        "timestamp": "2026-11-03T18:00:00Z",
        "topic": "custom/topic",
        "object": {"foo": "bar"},
      };

      final bodyBytes = utf8.encode(jsonEncode(payload));
      final sig = sign(bodyBytes);

      await dispatcher.handleRequest(
        rawBodyBytes: bodyBytes,
        signatureHeader: sig,
      );

      expect(events.length, equals(1));
      expect(events.first.topic, equals("custom/topic"));
      expect((events.first.object as Map)["foo"], equals("bar"));
    });

    test("rejects request with invalid signature before dispatching", () async {
      var wasCalled = false;
      dispatcher.onOrderCreated((_) => wasCalled = true);

      final payload = {
        "id": "evt_1",
        "topic": "order/created",
        "object": {"order_id": "123"},
      };

      final bodyBytes = utf8.encode(jsonEncode(payload));

      expect(
        () => dispatcher.handleRequest(
          rawBodyBytes: bodyBytes,
          signatureHeader: "tampered_signature",
        ),
        throwsA(isA<WhatnotWebhookSignatureException>()),
      );

      expect(wasCalled, isFalse);
    });
  });
}
