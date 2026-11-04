// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated API class: ShippingApi
// ignore_for_file: unused_import, no_leading_underscores_for_library_prefixes
import "../../http/whatnot_http_client.dart" as _i1;
import "../models.dart" as _i2;

/// Resource client for ShippingApi operations.
class ShippingApi(final _i1.WhatnotHttpClient _client) {
  /// Get a dimension profile
  Future<_i2.DimensionProfile> getDimensionProfile(
    String dimensionProfileId,
  ) async {
    final response = await _client.get(
      "/shipping/dimension_profiles/$dimensionProfileId",
    );
    return _i2.DimensionProfile.fromJson(response as Map<String, dynamic>);
  }

  /// List dimension profiles
  Future<_i2.PageResponseDimensionProfile> listDimensionProfiles({
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
      "/shipping/dimension_profiles",
      queryParameters: queryParameters,
    );
    return _i2.PageResponseDimensionProfile.fromJson(
      response as Map<String, dynamic>,
    );
  }
}
