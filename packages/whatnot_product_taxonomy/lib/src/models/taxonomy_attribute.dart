/// Specification of an item attribute in Whatnot's marketplace taxonomy.
class TaxonomyAttribute(
  /// The unique numeric identifier of the attribute.
  final int id,

  /// The attribute key slug (e.g. `sneakers.shoe_size`, `pokemon.card_condition`).
  final String key,

  /// The display label for the attribute (e.g. `Size`, `Condition`).
  final String label,

  /// The expected data type (`STRING`, `INTEGER`, `FLOAT`, `BOOLEAN`).
  final String type,

  /// Whether values outside the predefined [values] list are permitted.
  final bool allowsCustomValues,

  /// Predefined valid options/values for this attribute.
  final List<String> values,

  /// Optional minimum numeric value if applicable.
  final num? min,

  /// Optional maximum numeric value if applicable.
  final num? max,
) {
  factory TaxonomyAttribute.fromJson(Map<String, dynamic> json) =>
      TaxonomyAttribute(
        (json["id"] as num).toInt(),
        json["key"] as String? ?? "",
        json["label"] as String? ?? "",
        json["type"] as String? ?? "STRING",
        json["allows_custom_values"] as bool? ?? false,
        (json["values"] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
            const [],
        json["min"] as num?,
        json["max"] as num?,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "label": label,
    "type": type,
    "allows_custom_values": allowsCustomValues,
    "values": values,
    if (min != null) "min": min,
    if (max != null) "max": max,
  };

  @override
  String toString() =>
      "TaxonomyAttribute(id: $id, key: $key, label: $label, type: $type)";
}

/// An attribute bundled with its requirement status for a specific category.
class CategoryAttributeDetail(
  /// The underlying attribute definition.
  final TaxonomyAttribute attribute,

  /// Whether this attribute must be provided when listing in the category.
  final bool isRequired,
) {
  @override
  String toString() =>
      "CategoryAttributeDetail(${attribute.key}, required: $isRequired)";
}
