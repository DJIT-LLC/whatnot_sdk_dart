import "dart:convert";

import "package:crypto/crypto.dart";

import "../errors/whatnot_exception.dart";

/// Cryptographic verifier for Whatnot Webhook signatures (`X-Whatnot-Webhook-Signature`).
class WhatnotWebhookVerifier(
  /// The secret key configured for the webhook endpoint.
  final String secret,
) {
  /// Verifies whether the incoming [signature] matches the HMAC-SHA256 hash of [rawBodyBytes].
  bool verify({required List<int> rawBodyBytes, required String signature}) {
    if (signature.isEmpty || secret.isEmpty) return false;

    final hmac = Hmac(sha256, utf8.encode(secret));
    final digest = hmac.convert(rawBodyBytes);
    final expectedSignature = digest.toString().toLowerCase();

    return _timingSafeEqual(expectedSignature, signature.toLowerCase().trim());
  }

  /// Verifies the [signature] and throws a [WhatnotWebhookSignatureException] if invalid.
  void verifyOrThrow({
    required List<int> rawBodyBytes,
    required String? signature,
  }) {
    if (signature == null || signature.isEmpty) {
      throw const WhatnotWebhookSignatureException(
        "Missing X-Whatnot-Webhook-Signature header",
      );
    }

    if (!verify(rawBodyBytes: rawBodyBytes, signature: signature)) {
      throw const WhatnotWebhookSignatureException(
        "Invalid X-Whatnot-Webhook-Signature for payload",
      );
    }
  }

  /// Compares two strings in constant time to prevent timing attacks.
  static bool _timingSafeEqual(String a, String b) {
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return result == 0;
  }
}
