import "dart:async";
import "dart:convert";
import "dart:math" as math;

import "package:http/http.dart" as http;

import "../config/whatnot_config.dart";
import "../errors/whatnot_exception.dart";
import "rate_limit_info.dart";

/// Internal HTTP client that manages authentication, rate limiting, and RFC 9457 errors.
class WhatnotHttpClient(final WhatnotConfig config) {
  late final http.Client _client = config.httpClient ?? http.Client();
  final bool _ownsClient = config.httpClient == null;

  /// Closes the underlying HTTP client if owned by this instance.
  void close() {
    if (_ownsClient) {
      _client.close();
    }
  }

  /// Sends a GET request to [path] with optional [queryParameters].
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) =>
      _request("GET", path, queryParameters: queryParameters);

  /// Sends a POST request to [path] with optional [body] and [queryParameters].
  Future<dynamic> post(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) => _request("POST", path, body: body, queryParameters: queryParameters);

  /// Sends a PATCH request to [path] with optional [body] and [queryParameters].
  Future<dynamic> patch(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) => _request("PATCH", path, body: body, queryParameters: queryParameters);

  /// Sends a DELETE request to [path] with optional [queryParameters].
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) => _request("DELETE", path, queryParameters: queryParameters);

  Uri _buildUri(String path, [Map<String, dynamic>? queryParameters]) {
    final baseUri = Uri.parse(config.baseUrl);
    var cleanPath = path;
    if (cleanPath.startsWith("/")) {
      cleanPath = cleanPath.substring(1);
    }

    final combinedPath = baseUri.path.endsWith("/")
        ? "${baseUri.path}$cleanPath"
        : "${baseUri.path}/$cleanPath";

    Map<String, dynamic>? filteredParams;
    if (queryParameters != null && queryParameters.isNotEmpty) {
      filteredParams = {};
      for (final entry in queryParameters.entries) {
        if (entry.value != null) {
          filteredParams[entry.key] = entry.value.toString();
        }
      }
    }

    return baseUri.replace(
      path: combinedPath,
      queryParameters: filteredParams?.isEmpty ?? true ? null : filteredParams,
    );
  }

  Future<dynamic> _request(
    String method,
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = _buildUri(path, queryParameters);
    var attempt = 0;

    while (true) {
      attempt++;
      final headers = <String, String>{
        "Authorization": "Bearer ${config.apiKey}",
        "Accept": "application/json, application/problem+json",
      };

      String? encodedBody;
      if (body != null) {
        headers["Content-Type"] = "application/json";
        encodedBody = body is String ? body : jsonEncode(body);
      }

      http.Response response;
      try {
        final request = http.Request(method, uri);
        request.headers.addAll(headers);
        if (encodedBody != null) {
          request.body = encodedBody;
        }

        final streamed = await _client.send(request).timeout(config.timeout);
        response = await http.Response.fromStream(streamed);
      } on TimeoutException {
        throw WhatnotServerException(
          0,
          "Request timed out after ${config.timeout.inSeconds} seconds for $method $uri",
        );
      } catch (e) {
        if (e is WhatnotApiException) rethrow;
        throw WhatnotClientException(0, "Network transport error: $e");
      }

      final rateLimit = RateLimitInfo.fromHeaders(response.headers);

      // Handle Rate Limiting (429)
      if (response.statusCode == 429) {
        if (attempt <= config.maxRetries) {
          final waitDuration =
              rateLimit.retryAfter ??
              Duration(milliseconds: (500 * math.pow(2, attempt - 1)).round());
          await Future<void>.delayed(waitDuration);
          continue; // Retry request
        }

        throw WhatnotRateLimitException(
          response.statusCode,
          "Rate limit exceeded for $method $uri",
          rateLimitInfo: rateLimit,
          retryAfter: rateLimit.retryAfter,
          responseBody: response.body,
          headers: response.headers,
        );
      }

      // Success
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) return null;
        try {
          return jsonDecode(response.body);
        } catch (_) {
          return response.body;
        }
      }

      // Error Handling
      _handleErrorResponse(response, rateLimit);
    }
  }

  Never _handleErrorResponse(http.Response response, RateLimitInfo? rateLimit) {
    Map<String, dynamic>? problemJson;
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        problemJson = decoded;
      }
    } catch (_) {}

    final type = problemJson?["type"] as String?;
    final title = problemJson?["title"] as String?;
    final detail = problemJson?["detail"] as String?;
    final message = detail ?? title ?? "HTTP error ${response.statusCode}";

    if (type != null || title != null || detail != null) {
      throw WhatnotProblemException(
        response.statusCode,
        message,
        type: type,
        title: title,
        detail: detail,
        raw: problemJson,
        responseBody: response.body,
        headers: response.headers,
      );
    }

    switch (response.statusCode) {
      case 401:
        throw WhatnotAuthenticationException(
          response.statusCode,
          message,
          responseBody: response.body,
          headers: response.headers,
        );
      case 403:
        throw WhatnotForbiddenException(
          response.statusCode,
          message,
          responseBody: response.body,
          headers: response.headers,
        );
      case 404:
        throw WhatnotNotFoundException(
          response.statusCode,
          message,
          responseBody: response.body,
          headers: response.headers,
        );
      case 422:
        throw WhatnotValidationException(
          response.statusCode,
          message,
          responseBody: response.body,
          headers: response.headers,
        );
      default:
        if (response.statusCode >= 500) {
          throw WhatnotServerException(
            response.statusCode,
            message,
            responseBody: response.body,
            headers: response.headers,
          );
        }
        throw WhatnotClientException(
          response.statusCode,
          message,
          responseBody: response.body,
          headers: response.headers,
        );
    }
  }
}
