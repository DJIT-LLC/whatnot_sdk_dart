import "package:http/http.dart" as http;

/// Configuration options for the Whatnot Seller API client.
class WhatnotConfig(
  /// The Bearer token for authenticating requests with Whatnot.
  final String apiKey, {

  /// The base URL for the Whatnot Seller REST v2 API.
  final String baseUrl = "https://api.whatnot.com/seller-api/rest/v2",

  /// Custom [http.Client] instance for testing or connection pooling.
  final http.Client? httpClient,

  /// Request timeout duration.
  final Duration timeout = const Duration(seconds: 30),

  /// Maximum number of automatic retries on rate limits (HTTP 429).
  final int maxRetries = 3,
});
