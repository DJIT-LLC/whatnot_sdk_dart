// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated API class: OrdersApi
// ignore_for_file: unused_import, no_leading_underscores_for_library_prefixes
import "../../http/whatnot_http_client.dart" as _i1;
import "../models.dart" as _i2;

/// Resource client for OrdersApi operations.
class OrdersApi(final _i1.WhatnotHttpClient _client) {
  /// Get an order
  Future<_i2.Order> getOrder(String orderId) async {
    final response = await _client.get("/orders/$orderId");
    return _i2.Order.fromJson(response as Map<String, dynamic>);
  }

  /// Get an order item
  Future<_i2.OrderItem> getOrderItem(String orderId, String itemId) async {
    final response = await _client.get("/orders/$orderId/items/$itemId");
    return _i2.OrderItem.fromJson(response as Map<String, dynamic>);
  }

  /// List orders
  Future<_i2.PageResponseOrder> list({
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
      "/orders",
      queryParameters: queryParameters,
    );
    return _i2.PageResponseOrder.fromJson(response as Map<String, dynamic>);
  }

  /// List order items
  Future<_i2.PageResponseOrderItem> listOrderItems(
    String orderId, {
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
      "/orders/$orderId/items",
      queryParameters: queryParameters,
    );
    return _i2.PageResponseOrderItem.fromJson(response as Map<String, dynamic>);
  }

  /// Cancel an order
  Future<_i2.Order> cancelOrder(
    String orderId,
    _i2.CancelOrderRequest request,
  ) async {
    final response = await _client.post(
      "/orders/$orderId/cancel",
      body: request.toJson(),
    );
    return _i2.Order.fromJson(response as Map<String, dynamic>);
  }
}
