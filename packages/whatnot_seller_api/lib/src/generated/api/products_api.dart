// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated API class: ProductsApi
// ignore_for_file: unused_import, no_leading_underscores_for_library_prefixes
import "../../http/whatnot_http_client.dart" as _i1;
import "../models.dart" as _i2;

/// Resource client for ProductsApi operations.
class ProductsApi(final _i1.WhatnotHttpClient _client) {
  /// Create a product
  Future<_i2.Product> createProduct(_i2.CreateProductRequest request) async {
    final response = await _client.post("/products", body: request.toJson());
    return _i2.Product.fromJson(response as Map<String, dynamic>);
  }

  /// List products
  Future<_i2.PageResponseProduct> list({
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
      "/products",
      queryParameters: queryParameters,
    );
    return _i2.PageResponseProduct.fromJson(response as Map<String, dynamic>);
  }

  /// Update a product
  Future<_i2.Product> updateProduct(
    String productId,
    _i2.UpdateProductRequest request,
  ) async {
    final response = await _client.patch(
      "/products/$productId",
      body: request.toJson(),
    );
    return _i2.Product.fromJson(response as Map<String, dynamic>);
  }

  /// Get a product
  Future<_i2.Product> getProduct(String productId) async {
    final response = await _client.get("/products/$productId");
    return _i2.Product.fromJson(response as Map<String, dynamic>);
  }

  /// Delete a product
  Future<void> deleteProduct(String productId) async {
    await _client.delete("/products/$productId");
  }

  /// Update product variants
  Future<dynamic> batchUpdateProductVariants(
    String productId,
    _i2.UpdateProductVariantsRequest request,
  ) async {
    return await _client.patch(
      "/products/$productId/variants",
      body: request.toJson(),
    );
  }

  /// List product variants
  Future<_i2.PageResponseProductVariant> listProductVariants(
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
      "/products/$productId/variants",
      queryParameters: queryParameters,
    );
    return _i2.PageResponseProductVariant.fromJson(
      response as Map<String, dynamic>,
    );
  }

  /// Get a product variant
  Future<_i2.ProductVariant> getProductVariant(
    String productId,
    String id,
  ) async {
    final response = await _client.get("/products/$productId/variants/$id");
    return _i2.ProductVariant.fromJson(response as Map<String, dynamic>);
  }
}
