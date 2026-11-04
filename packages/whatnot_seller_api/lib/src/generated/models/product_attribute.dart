// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ProductAttribute
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class ProductAttribute(
  /// The product attribute's id.
  final String id,

  /// The product attribute's display name, if the definition is known.
  final String? name,

  /// The attribute's value for this product.
  final String value,
) {
  factory ProductAttribute.fromJson(Map<String, dynamic> json) =>
      ProductAttribute(
        json["id"] as String,
        json["name"] as String?,
        json["value"] as String,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    if (name != null) "name": name,
    "value": value,
  };
}
