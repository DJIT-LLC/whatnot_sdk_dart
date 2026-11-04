// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated API class: UsersApi
// ignore_for_file: unused_import, no_leading_underscores_for_library_prefixes
import "../../http/whatnot_http_client.dart" as _i1;
import "../models.dart" as _i2;

/// Resource client for UsersApi operations.
class UsersApi(final _i1.WhatnotHttpClient _client) {
  /// Get the current user
  Future<_i2.User> getMe() async {
    final response = await _client.get("/users/me");
    return _i2.User.fromJson(response as Map<String, dynamic>);
  }

  /// Disconnect the current application
  Future<void> disconnect() async {
    await _client.post("/users/disconnect");
  }
}
