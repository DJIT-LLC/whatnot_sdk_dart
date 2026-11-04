// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated API class: GeneralApi
// ignore_for_file: unused_import, no_leading_underscores_for_library_prefixes
import "../../http/whatnot_http_client.dart" as _i1;
import "../models.dart" as _i2;

/// Resource client for GeneralApi operations.
class GeneralApi(final _i1.WhatnotHttpClient _client) {
  /// Health check
  Future<_i2.RootResponse> root() async {
    final response = await _client.get("/");
    return _i2.RootResponse.fromJson(response as Map<String, dynamic>);
  }
}
