import "dart:convert";

import "package:crypto/crypto.dart";
import "package:test/test.dart";
import "package:whatnot_seller_api/whatnot_seller_api.dart";

void main() {
  group("WhatnotWebhookVerifier", () {
    const secret = "test_webhook_secret_xyz";
    final verifier = WhatnotWebhookVerifier(secret);

    test("validates correct HMAC-SHA256 signature", () {
      final payloadBytes = utf8.encode('{"event":"order/created","id":"123"}');
      final hmac = Hmac(sha256, utf8.encode(secret));
      final expectedSig = hmac.convert(payloadBytes).toString();

      final isValid = verifier.verify(
        rawBodyBytes: payloadBytes,
        signature: expectedSig,
      );

      expect(isValid, isTrue);
    });

    test("validates signature case-insensitively", () {
      final payloadBytes = utf8.encode('{"data":"case_check"}');
      final hmac = Hmac(sha256, utf8.encode(secret));
      final expectedSig = hmac.convert(payloadBytes).toString().toUpperCase();

      final isValid = verifier.verify(
        rawBodyBytes: payloadBytes,
        signature: expectedSig,
      );

      expect(isValid, isTrue);
    });

    test("rejects tampered payload body", () {
      final originalBytes = utf8.encode('{"amount":100}');
      final tamperedBytes = utf8.encode('{"amount":999}');
      final hmac = Hmac(sha256, utf8.encode(secret));
      final originalSig = hmac.convert(originalBytes).toString();

      final isValid = verifier.verify(
        rawBodyBytes: tamperedBytes,
        signature: originalSig,
      );

      expect(isValid, isFalse);
    });

    test("rejects signature created with different secret", () {
      final payloadBytes = utf8.encode('{"amount":100}');
      final wrongHmac = Hmac(sha256, utf8.encode("different_secret"));
      final wrongSig = wrongHmac.convert(payloadBytes).toString();

      final isValid = verifier.verify(
        rawBodyBytes: payloadBytes,
        signature: wrongSig,
      );

      expect(isValid, isFalse);
    });

    test("verifyOrThrow throws on invalid signature", () {
      final payloadBytes = utf8.encode('{"status":"pending"}');

      expect(
        () => verifier.verifyOrThrow(
          rawBodyBytes: payloadBytes,
          signature: "invalid_hex_string",
        ),
        throwsA(isA<WhatnotWebhookSignatureException>()),
      );
    });

    test("verifyOrThrow throws on null or empty signature", () {
      final payloadBytes = utf8.encode('{"status":"pending"}');

      expect(
        () =>
            verifier.verifyOrThrow(rawBodyBytes: payloadBytes, signature: null),
        throwsA(isA<WhatnotWebhookSignatureException>()),
      );

      expect(
        () => verifier.verifyOrThrow(rawBodyBytes: payloadBytes, signature: ""),
        throwsA(isA<WhatnotWebhookSignatureException>()),
      );
    });
  });
}
