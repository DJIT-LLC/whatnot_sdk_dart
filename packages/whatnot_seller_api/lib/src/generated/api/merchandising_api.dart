// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated API class: MerchandisingApi
// ignore_for_file: unused_import, no_leading_underscores_for_library_prefixes
import "../../http/whatnot_http_client.dart" as _i1;
import "../models.dart" as _i2;

/// Resource client for MerchandisingApi operations.
class MerchandisingApi(final _i1.WhatnotHttpClient _client) {
  /// Update a product's merchandising
  Future<_i2.MerchandiseProductResponse> merchandiseProduct(
    String productId,
    _i2.MerchandiseProductRequest request,
  ) async {
    final response = await _client.post(
      "/merchandising/products/$productId",
      body: request.toJson(),
    );
    return _i2.MerchandiseProductResponse.fromJson(
      response as Map<String, dynamic>,
    );
  }

  /// Get a product's merchandising
  Future<_i2.ProductMerchandising> getProduct(String productId) async {
    final response = await _client.get("/merchandising/products/$productId");
    return _i2.ProductMerchandising.fromJson(response as Map<String, dynamic>);
  }

  /// List a product's shows
  Future<_i2.PageResponseShow> listProductShows(
    String productId, {
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
      "/merchandising/products/$productId/shows",
      queryParameters: queryParameters,
    );
    return _i2.PageResponseShow.fromJson(response as Map<String, dynamic>);
  }
}
