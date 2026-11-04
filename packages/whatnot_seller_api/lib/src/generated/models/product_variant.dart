// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ProductVariant
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "selected_option.dart" as _i1;
import "variant_pricing.dart" as _i2;
import "variant_inventory.dart" as _i3;
import "media.dart" as _i4;

class ProductVariant(
  /// The variant's id.
  final String id,

  /// Parent product identifier.
  final String productId,

  /// Seller SKU, if set.
  final String? sku,

  /// Seller external identifier, if set.
  final String? externalId,

  /// Selected product option values.
  final List<_i1.SelectedOption> selectedOptions,

  /// Staged format-specific prices.
  final _i2.VariantPricing pricing,

  /// Seller-declared country of origin.
  final String? countryOfOrigin,

  /// Default-location inventory.
  final _i3.VariantInventory inventory,

  /// Resolved variant images.
  final List<_i4.Media> media,
) {
  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
    json["id"] as String,
    json["product_id"] as String,
    json["sku"] as String?,
    json["external_id"] as String?,
    (json["selected_options"] as List<dynamic>)
        .map((e) => _i1.SelectedOption.fromJson(e as Map<String, dynamic>))
        .toList(),
    _i2.VariantPricing.fromJson(json["pricing"] as Map<String, dynamic>),
    json["country_of_origin"] as String?,
    _i3.VariantInventory.fromJson(json["inventory"] as Map<String, dynamic>),
    (json["media"] as List<dynamic>)
        .map((e) => _i4.Media.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    if (sku != null) "sku": sku,
    if (externalId != null) "external_id": externalId,
    "selected_options": selectedOptions.map((e) => e.toJson()).toList(),
    "pricing": pricing.toJson(),
    if (countryOfOrigin != null) "country_of_origin": countryOfOrigin,
    "inventory": inventory.toJson(),
    "media": media.map((e) => e.toJson()).toList(),
  };
}
