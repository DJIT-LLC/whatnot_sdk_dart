// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated API class: ShowsApi
// ignore_for_file: unused_import, no_leading_underscores_for_library_prefixes
import "../../http/whatnot_http_client.dart" as _i1;
import "../models.dart" as _i2;

/// Resource client for ShowsApi operations.
class ShowsApi(final _i1.WhatnotHttpClient _client) {
  /// Get a show
  Future<_i2.Show> getShow(String showId) async {
    final response = await _client.get("/shows/$showId");
    return _i2.Show.fromJson(response as Map<String, dynamic>);
  }

  /// List shows
  Future<_i2.PageResponseShow> list({
    String? status,
    int? limit,
    String? cursor,
    bool? reverse,
  }) async {
    final queryParameters = <String, dynamic>{
      if (status != null) "status": status,
      if (limit != null) "limit": limit,
      if (cursor != null) "cursor": cursor,
      if (reverse != null) "reverse": reverse,
    };
    final response = await _client.get(
      "/shows",
      queryParameters: queryParameters,
    );
    return _i2.PageResponseShow.fromJson(response as Map<String, dynamic>);
  }
}
