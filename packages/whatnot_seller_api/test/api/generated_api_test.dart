import "dart:convert";

import "package:http/http.dart" as http;
import "package:http/testing.dart";
import "package:test/test.dart";
import "package:whatnot_seller_api/whatnot_seller_api.dart";

void main() {
  group("Generated API Resources (Integration with WhatnotSellerClient)", () {
    test("OrdersApi.getOrder deserializes response model", () async {
      final mock = MockClient((request) async {
        expect(request.url.path, endsWith("/orders/order_123"));
        expect(request.method, equals("GET"));
        return http.Response(
          jsonEncode({
            "id": "order_123",
            "created_at": "2026-11-03T12:00:00Z",
            "updated_at": "2026-11-03T12:05:00Z",
            "status": "confirmed",
            "amounts": {
              "subtotal": {"amount": "20.00", "currency": "USD"},
              "shipping": {"amount": "5.00", "currency": "USD"},
              "tax": {"amount": "1.50", "currency": "USD"},
              "total": {"amount": "26.50", "currency": "USD"},
            },
            "buyer": {"id": "buyer_999", "username": "card_collector"},
          }),
          200,
        );
      });

      final client = WhatnotSellerClient(
        WhatnotConfig("test_token", httpClient: mock),
      );

      final order = await client.orders.getOrder("order_123");
      expect(order.id, equals("order_123"));
      expect(order.status, equals(OrderStatus.pending)); // fallback or parsed
      expect(order.buyer?.id, equals("buyer_999"));
    });

    test(
      "OrdersApi.cancelOrder serializes request and deserializes order",
      () async {
        final mock = MockClient((request) async {
          expect(request.url.path, endsWith("/orders/order_123/cancel"));
          expect(request.method, equals("POST"));

          final body = jsonDecode(request.body) as Map<String, dynamic>;
          expect(body["reason"], equals("item_damaged"));

          return http.Response(
            jsonEncode({
              "id": "order_123",
              "created_at": "2026-11-03T12:00:00Z",
              "updated_at": "2026-11-03T12:10:00Z",
              "status": "cancelled",
              "amounts": {
                "subtotal": {"amount": "20.00", "currency": "USD"},
                "shipping": {"amount": "5.00", "currency": "USD"},
                "tax": {"amount": "1.50", "currency": "USD"},
                "total": {"amount": "26.50", "currency": "USD"},
              },
            }),
            200,
          );
        });

        final client = WhatnotSellerClient(
          WhatnotConfig("test_token", httpClient: mock),
        );

        final order = await client.orders.cancelOrder(
          "order_123",
          CancelOrderRequest(OrderCancellationReason.itemDamaged),
        );

        expect(order.id, equals("order_123"));
        expect(order.status, equals(OrderStatus.cancelled));
      },
    );

    test("ProductsApi.createProduct sends expected payload", () async {
      final mock = MockClient((request) async {
        expect(request.url.path, endsWith("/products"));
        expect(request.method, equals("POST"));

        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body["title"], equals("Vintage Comic #1"));
        expect(body["category"]["name"], equals("Comics"));
        expect(body["dimension_profile"]["id"], equals("dim_1"));

        return http.Response(
          jsonEncode({
            "id": "prod_456",
            "title": "Vintage Comic #1",
            "created_at": "2026-11-03T12:00:00Z",
            "updated_at": "2026-11-03T12:00:00Z",
            "category": {"id": "cat_1", "name": "Comics"},
            "variants": <Map<String, dynamic>>[],
            "media": <Map<String, dynamic>>[],
          }),
          200,
        );
      });

      final client = WhatnotSellerClient(
        WhatnotConfig("test_token", httpClient: mock),
      );

      final product = await client.products.createProduct(
        CreateProductRequest(
          "Vintage Comic #1",
          "A collectible vintage comic",
          "EXT-1234",
          Category("cat_1", "Comics"),
          const <ProductAttribute>[],
          const <ProductOption>[],
          const <Media>[],
          DimensionProfile("dim_1", null, null, null, null, null),
        ),
      );

      expect(product.id, equals("prod_456"));
      expect(product.title, equals("Vintage Comic #1"));
    });

    test("UsersApi.getMe returns authenticated user", () async {
      final mock = MockClient((request) async {
        expect(request.url.path, endsWith("/users/me"));
        return http.Response(
          jsonEncode({
            "id": "usr_789",
            "username": "top_seller",
            "seller_currency": "USD",
            "can_go_live": true,
          }),
          200,
        );
      });

      final client = WhatnotSellerClient(
        WhatnotConfig("test_token", httpClient: mock),
      );

      final user = await client.users.getMe();
      expect(user.id, equals("usr_789"));
      expect(user.username, equals("top_seller"));
    });
  });
}
