// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated API class: ShipmentsApi
// ignore_for_file: unused_import, no_leading_underscores_for_library_prefixes
import "../../http/whatnot_http_client.dart" as _i1;
import "../models.dart" as _i2;

/// Resource client for ShipmentsApi operations.
class ShipmentsApi(final _i1.WhatnotHttpClient _client) {
  /// Get a shipment
  Future<_i2.Shipment> getShipment(String shipmentId) async {
    final response = await _client.get("/shipments/$shipmentId");
    return _i2.Shipment.fromJson(response as Map<String, dynamic>);
  }

  /// Get a shipment item
  Future<_i2.ShipmentItem> getShipmentItem(
    String shipmentId,
    String itemId,
  ) async {
    final response = await _client.get("/shipments/$shipmentId/items/$itemId");
    return _i2.ShipmentItem.fromJson(response as Map<String, dynamic>);
  }

  /// List shipments
  Future<_i2.PageResponseShipment> list({
    int? limit,
    String? cursor,
    bool? reverse,
  }) async {
    final queryParameters = <String, dynamic>{
      if (limit != null) "limit": limit,
      if (cursor != null) "cursor": cursor,
      if (reverse != null) "reverse": reverse,
    };
    final response = await _client.get(
      "/shipments",
      queryParameters: queryParameters,
    );
    return _i2.PageResponseShipment.fromJson(response as Map<String, dynamic>);
  }

  /// List shipment items
  Future<_i2.PageResponseShipmentItem> listShipmentItems(
    String shipmentId, {
    int? limit,
    String? cursor,
    bool? reverse,
  }) async {
    final queryParameters = <String, dynamic>{
      if (limit != null) "limit": limit,
      if (cursor != null) "cursor": cursor,
      if (reverse != null) "reverse": reverse,
    };
    final response = await _client.get(
      "/shipments/$shipmentId/items",
      queryParameters: queryParameters,
    );
    return _i2.PageResponseShipmentItem.fromJson(
      response as Map<String, dynamic>,
    );
  }

  /// Add a tracking code to order items
  Future<void> addTrackingCode(_i2.AddTrackingCodeRequest request) async {
    await _client.post("/shipments/add_tracking_code", body: request.toJson());
  }

  /// Request a shipping label
  Future<_i2.LabelGenerationAcceptedResponse> generateLabel(
    String shipmentId,
  ) async {
    final response = await _client.post(
      "/shipments/$shipmentId/generate_label",
    );
    return _i2.LabelGenerationAcceptedResponse.fromJson(
      response as Map<String, dynamic>,
    );
  }
}
