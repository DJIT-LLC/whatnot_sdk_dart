/// Information extracted from IETF RateLimit and Retry-After response headers.
class RateLimitInfo(
  /// The maximum number of requests allowed in the rate limit window.
  final int? limit,

  /// The estimated number of requests remaining in the current window.
  final int? remaining,

  /// The duration remaining until the current rate limit window resets.
  final Duration? reset,

  /// The duration recommended to wait before retrying after an HTTP 429 response.
  final Duration? retryAfter,
) {
  /// Extracts rate limit information from HTTP response [headers].
  factory RateLimitInfo.fromHeaders(Map<String, String> headers) {
    // Case-insensitive header lookup
    String? getHeader(String name) {
      final lowerName = name.toLowerCase();
      for (final entry in headers.entries) {
        if (entry.key.toLowerCase() == lowerName) {
          return entry.value;
        }
      }
      return null;
    }

    int? parsedLimit;
    final limitHeader = getHeader("ratelimit-limit");
    if (limitHeader != null) {
      // Formats like "10, 10;w=1" or "10"
      final parts = limitHeader.split(",");
      parsedLimit = int.tryParse(parts.first.trim());
    }

    int? parsedRemaining;
    final remainingHeader = getHeader("ratelimit-remaining");
    if (remainingHeader != null) {
      parsedRemaining = int.tryParse(remainingHeader.trim());
    }

    Duration? parsedReset;
    final resetHeader = getHeader("ratelimit-reset");
    if (resetHeader != null) {
      final seconds = int.tryParse(resetHeader.trim());
      if (seconds != null) {
        parsedReset = Duration(seconds: seconds);
      }
    }

    Duration? parsedRetryAfter;
    final retryAfterHeader = getHeader("retry-after");
    if (retryAfterHeader != null) {
      final seconds = int.tryParse(retryAfterHeader.trim());
      if (seconds != null) {
        parsedRetryAfter = Duration(seconds: seconds);
      }
    }

    return RateLimitInfo(
      parsedLimit,
      parsedRemaining,
      parsedReset,
      parsedRetryAfter,
    );
  }

  @override
  String toString() =>
      "RateLimitInfo(limit: $limit, remaining: $remaining, reset: $reset, retryAfter: $retryAfter)";
}
