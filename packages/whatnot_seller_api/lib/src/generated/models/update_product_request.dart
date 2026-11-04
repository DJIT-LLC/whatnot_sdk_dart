// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: UpdateProductRequest
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "category.dart" as _i1;
import "product_attribute.dart" as _i2;
import "product_option.dart" as _i3;
import "media.dart" as _i4;
import "dimension_profile.dart" as _i5;

/// The mutable fields for a partial product update.
class UpdateProductRequest(
  /// The product's title.
  final String? title,

  /// The product's description.
  final String? description,

  /// The seller-provided external identifier for the product.
  final String? externalId,

  /// The product's category.
  final _i1.Category? category,

  /// The product's attribute values.
  final List<_i2.ProductAttribute>? attributes,

  /// The product's option axes (e.g. Color, Size).
  final List<_i3.ProductOption>? options,

  /// The product's images.
  final List<_i4.Media>? media,

  /// The product's dimension profile.
  final _i5.DimensionProfile? dimensionProfile,
) {
  factory UpdateProductRequest.fromJson(Map<String, dynamic> json) =>
      UpdateProductRequest(
        json["title"] as String?,
        json["description"] as String?,
        json["external_id"] as String?,
        json["category"] != null
            ? _i1.Category.fromJson(json["category"] as Map<String, dynamic>)
            : null,
        (json["attributes"] as List<dynamic>?)
            ?.map(
              (e) => _i2.ProductAttribute.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        (json["options"] as List<dynamic>?)
            ?.map((e) => _i3.ProductOption.fromJson(e as Map<String, dynamic>))
            .toList(),
        (json["media"] as List<dynamic>?)
            ?.map((e) => _i4.Media.fromJson(e as Map<String, dynamic>))
            .toList(),
        json["dimension_profile"] != null
            ? _i5.DimensionProfile.fromJson(
                json["dimension_profile"] as Map<String, dynamic>,
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
    if (title != null) "title": title,
    if (description != null) "description": description,
    if (externalId != null) "external_id": externalId,
    if (category != null) "category": category?.toJson(),
    if (attributes != null)
      "attributes": attributes?.map((e) => e.toJson()).toList(),
    if (options != null) "options": options?.map((e) => e.toJson()).toList(),
    if (media != null) "media": media?.map((e) => e.toJson()).toList(),
    if (dimensionProfile != null)
      "dimension_profile": dimensionProfile?.toJson(),
  };
}
