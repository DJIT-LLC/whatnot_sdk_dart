// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated API class: AnalyticsApi
// ignore_for_file: unused_import, no_leading_underscores_for_library_prefixes
import "../../http/whatnot_http_client.dart" as _i1;
import "../models.dart" as _i2;

/// Resource client for AnalyticsApi operations.
class AnalyticsApi(final _i1.WhatnotHttpClient _client) {
  /// Get show analytics
  Future<_i2.ShowAnalytics> getShow(String showId) async {
    final response = await _client.get("/analytics/shows/$showId");
    return _i2.ShowAnalytics.fromJson(response as Map<String, dynamic>);
  }
}
