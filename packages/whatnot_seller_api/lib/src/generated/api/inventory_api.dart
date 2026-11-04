// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated API class: InventoryApi
// ignore_for_file: unused_import, no_leading_underscores_for_library_prefixes
import "../../http/whatnot_http_client.dart" as _i1;
import "../models.dart" as _i2;

/// Resource client for InventoryApi operations.
class InventoryApi(final _i1.WhatnotHttpClient _client) {
  /// Adjust inventory
  Future<dynamic> adjust(_i2.AdjustInventoryLevelsRequest request) async {
    return await _client.post("/inventory/adjust", body: request.toJson());
  }

  /// Set inventory
  Future<dynamic> set(_i2.SetInventoryLevelsRequest request) async {
    return await _client.post("/inventory/set", body: request.toJson());
  }
}
