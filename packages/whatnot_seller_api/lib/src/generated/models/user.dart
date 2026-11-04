// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: User
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "media.dart" as _i1;

class User(
  /// The user's ID, encoded as a decimal string.
  final String id,

  /// The user's username.
  final String username,

  /// The user's display name, if set.
  final String? displayName,

  /// The user's profile image, if set.
  final _i1.Media? image,

  /// The seller's ISO 4217 currency code.
  final String sellerCurrency,

  /// The user's ISO 3166-1 alpha-2 country code.
  final String? countryCode,

  /// Whether the user is allowed to go live.
  final bool canGoLive,
) {
  factory User.fromJson(Map<String, dynamic> json) => User(
    json["id"] as String,
    json["username"] as String,
    json["display_name"] as String?,
    json["image"] != null
        ? _i1.Media.fromJson(json["image"] as Map<String, dynamic>)
        : null,
    json["seller_currency"] as String,
    json["country_code"] as String?,
    json["can_go_live"] as bool,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    if (displayName != null) "display_name": displayName,
    if (image != null) "image": image?.toJson(),
    "seller_currency": sellerCurrency,
    if (countryCode != null) "country_code": countryCode,
    "can_go_live": canGoLive,
  };
}
