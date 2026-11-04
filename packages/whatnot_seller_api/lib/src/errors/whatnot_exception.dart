import "../http/rate_limit_info.dart";

/// Base exception thrown for any Whatnot Seller API error.
sealed class WhatnotApiException implements Exception {
  /// The HTTP status code of the response, or `0` for network failures.
  final int statusCode;

  /// Human-readable explanation of the error.
  final String message;

  /// The raw response body, if available.
  final String? responseBody;

  /// The HTTP response headers, if available.
  final Map<String, String>? headers;

  const WhatnotApiException(
    this.statusCode,
    this.message, {
    this.responseBody,
    this.headers,
  });

  @override
  String toString() =>
      "WhatnotApiException(status: $statusCode, message: $message)";
}

/// An error conforming to RFC 9457 ("Problem Details for HTTP APIs").
class WhatnotProblemException extends WhatnotApiException {
  /// A slug or URI identifying the specific problem type (e.g. `invalid-parameter`).
  final String? type;

  /// A short, human-readable summary of the problem type.
  final String? title;

  /// A human-readable explanation specific to this occurrence of the problem.
  final String? detail;

  /// Full raw JSON map returned by the problem payload.
  final Map<String, dynamic>? raw;

  const WhatnotProblemException(
    super.statusCode,
    super.message, {
    this.type,
    this.title,
    this.detail,
    this.raw,
    super.responseBody,
    super.headers,
  });

  @override
  String toString() =>
      "WhatnotProblemException(status: $statusCode, type: $type, title: $title, detail: $detail)";
}

/// Exception thrown when request rate limits have been exceeded (HTTP 429).
class WhatnotRateLimitException extends WhatnotApiException {
  /// Rate limit metadata parsed from response headers.
  final RateLimitInfo? rateLimitInfo;

  /// How long the caller should wait before retrying.
  final Duration? retryAfter;

  const WhatnotRateLimitException(
    super.statusCode,
    super.message, {
    this.rateLimitInfo,
    this.retryAfter,
    super.responseBody,
    super.headers,
  });

  @override
  String toString() =>
      "WhatnotRateLimitException(status: $statusCode, retryAfter: $retryAfter, message: $message)";
}

/// Exception thrown when authentication fails (HTTP 401).
class WhatnotAuthenticationException extends WhatnotApiException {
  const WhatnotAuthenticationException(
    super.statusCode,
    super.message, {
    super.responseBody,
    super.headers,
  });
}

/// Exception thrown when the caller has insufficient permissions or scopes (HTTP 403).
class WhatnotForbiddenException extends WhatnotApiException {
  const WhatnotForbiddenException(
    super.statusCode,
    super.message, {
    super.responseBody,
    super.headers,
  });
}

/// Exception thrown when the requested resource is not found (HTTP 404).
class WhatnotNotFoundException extends WhatnotApiException {
  const WhatnotNotFoundException(
    super.statusCode,
    super.message, {
    super.responseBody,
    super.headers,
  });
}

/// Exception thrown when request parameter validation fails (HTTP 422).
class WhatnotValidationException extends WhatnotApiException {
  const WhatnotValidationException(
    super.statusCode,
    super.message, {
    super.responseBody,
    super.headers,
  });
}

/// Exception thrown when an unexpected server error occurs (HTTP 5xx).
class WhatnotServerException extends WhatnotApiException {
  const WhatnotServerException(
    super.statusCode,
    super.message, {
    super.responseBody,
    super.headers,
  });
}

/// Exception thrown when a generic client-side HTTP error occurs (HTTP 4xx).
class WhatnotClientException extends WhatnotApiException {
  const WhatnotClientException(
    super.statusCode,
    super.message, {
    super.responseBody,
    super.headers,
  });
}

/// Exception thrown when an incoming webhook signature does not match.
class WhatnotWebhookSignatureException implements Exception {
  /// Human-readable explanation of why signature verification failed.
  final String message;

  const WhatnotWebhookSignatureException(this.message);

  @override
  String toString() => "WhatnotWebhookSignatureException: $message";
}
