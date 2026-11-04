import "dart:convert";

import "package:http/http.dart" as http;
import "package:http/testing.dart";
import "package:test/test.dart";
import "package:whatnot_seller_api/whatnot_seller_api.dart";

void main() {
  group("RateLimitInfo", () {
    test("parses rate limit headers correctly", () {
      final headers = {
        "RateLimit-Limit": "10, 10;w=1",
        "RateLimit-Remaining": "7",
        "RateLimit-Reset": "2",
        "Retry-After": "5",
      };

      final info = RateLimitInfo.fromHeaders(headers);

      expect(info.limit, equals(10));
      expect(info.remaining, equals(7));
      expect(info.reset, equals(const Duration(seconds: 2)));
      expect(info.retryAfter, equals(const Duration(seconds: 5)));
    });

    test("handles missing headers gracefully", () {
      final info = RateLimitInfo.fromHeaders({});

      expect(info.limit, isNull);
      expect(info.remaining, isNull);
      expect(info.reset, isNull);
      expect(info.retryAfter, isNull);
    });
  });

  group("WhatnotHttpClient", () {
    test("attaches Bearer token and Accept headers", () async {
      late http.Request capturedRequest;
      final mock = MockClient((request) async {
        capturedRequest = request;
        return http.Response(jsonEncode({"status": "ok"}), 200);
      });

      final config = WhatnotConfig("test_api_token_123", httpClient: mock);
      final client = WhatnotHttpClient(config);

      final result = await client.get("/test");

      expect(
        capturedRequest.headers["authorization"],
        equals("Bearer test_api_token_123"),
      );
      expect(capturedRequest.headers["accept"], contains("application/json"));
      expect(result, equals({"status": "ok"}));
    });

    test(
      "parses RFC 9457 Problem Details into WhatnotProblemException",
      () async {
        final problemPayload = {
          "type": "product-not-found",
          "title": "Product Not Found",
          "status": 404,
          "detail": "Product with ID prod_123 does not exist",
        };

        final mock = MockClient((request) async {
          return http.Response(
            jsonEncode(problemPayload),
            404,
            headers: {"content-type": "application/problem+json"},
          );
        });

        final client = WhatnotHttpClient(
          WhatnotConfig("test_token", httpClient: mock),
        );

        expect(
          () => client.get("/products/prod_123"),
          throwsA(
            isA<WhatnotProblemException>()
                .having((e) => e.statusCode, "statusCode", 404)
                .having((e) => e.type, "type", "product-not-found")
                .having((e) => e.title, "title", "Product Not Found")
                .having((e) => e.detail, "detail", contains("prod_123")),
          ),
        );
      },
    );

    test("automatically retries on HTTP 429 and succeeds", () async {
      var callCount = 0;
      final mock = MockClient((request) async {
        callCount++;
        if (callCount == 1) {
          return http.Response(
            jsonEncode({"detail": "rate limited"}),
            429,
            headers: {"retry-after": "0"},
          );
        }
        return http.Response(jsonEncode({"success": true}), 200);
      });

      final client = WhatnotHttpClient(
        WhatnotConfig("test_token", httpClient: mock, maxRetries: 2),
      );

      final result = await client.get("/orders");

      expect(callCount, equals(2));
      expect(result, equals({"success": true}));
    });

    test(
      "throws WhatnotRateLimitException when retries are exhausted",
      () async {
        final mock = MockClient((request) async {
          return http.Response(
            jsonEncode({"detail": "rate limited"}),
            429,
            headers: {"retry-after": "0"},
          );
        });

        final client = WhatnotHttpClient(
          WhatnotConfig("test_token", httpClient: mock, maxRetries: 1),
        );

        expect(
          () => client.get("/orders"),
          throwsA(isA<WhatnotRateLimitException>()),
        );
      },
    );
  });
}
