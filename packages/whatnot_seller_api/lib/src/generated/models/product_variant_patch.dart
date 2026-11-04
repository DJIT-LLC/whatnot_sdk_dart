// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ProductVariantPatch
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "variant_pricing_input.dart" as _i1;
import "media.dart" as _i2;

/// A partial variant update. Omitted fields are left unchanged.
class ProductVariantPatch(
  /// The variant's id.
  final String id,

  /// Seller SKU. Send null to clear.
  final String? sku,

  /// Seller external identifier. Send null to clear.
  final String? externalId,

  /// Format-specific prices to stage.
  final _i1.VariantPricingInput? pricing,

  /// Seller-declared country of origin, ISO 3166-1 alpha-2.
  final String? countryOfOrigin,

  /// Replaces the variant's image. Send one item. Omit the field to leave it unchanged. A variant image cannot be removed. Ingest is asynchronous, so a new image may be missing from this response.
  final List<_i2.Media>? media,
) {
  factory ProductVariantPatch.fromJson(Map<String, dynamic> json) =>
      ProductVariantPatch(
        json["id"] as String,
        json["sku"] as String?,
        json["external_id"] as String?,
        json["pricing"] != null
            ? _i1.VariantPricingInput.fromJson(
                json["pricing"] as Map<String, dynamic>,
              )
            : null,
        json["country_of_origin"] as String?,
        (json["media"] as List<dynamic>?)
            ?.map((e) => _i2.Media.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    if (sku != null) "sku": sku,
    if (externalId != null) "external_id": externalId,
    if (pricing != null) "pricing": pricing?.toJson(),
    if (countryOfOrigin != null) "country_of_origin": countryOfOrigin,
    if (media != null) "media": media?.map((e) => e.toJson()).toList(),
  };
}
