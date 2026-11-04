import "category_attribute_ref.dart";

/// A product category in Whatnot's marketplace taxonomy.
class TaxonomyCategory(
  /// The unique numeric identifier of the category.
  final int id,

  /// The machine-readable category slug (e.g. `pokemon_cards`, `funko_pop`).
  final String type,

  /// The human-readable display label (e.g. `Pokémon Cards`, `Funko`).
  final String label,

  /// The parent category ID, or `null` for root-level categories.
  final int? parentId,

  /// Whether items in this category accept inventory quantities.
  final bool allowsInventory,

  /// Attribute requirements and options associated with this category.
  final List<CategoryAttributeRef> attributes,
) {
  factory TaxonomyCategory.fromJson(Map<String, dynamic> json) =>
      TaxonomyCategory(
        (json["id"] as num).toInt(),
        json["type"] as String? ?? "",
        json["label"] as String? ?? "",
        (json["parent_id"] as num?)?.toInt(),
        json["allows_inventory"] as bool? ?? false,
        (json["attributes"] as List<dynamic>?)
                ?.whereType<Map<String, dynamic>>()
                .map(CategoryAttributeRef.fromJson)
                .toList() ??
            const [],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "label": label,
    if (parentId != null) "parent_id": parentId,
    "allows_inventory": allowsInventory,
    "attributes": attributes.map((a) => a.toJson()).toList(),
  };

  /// Whether this is a top-level root category.
  bool get isRoot => parentId == null;

  @override
  String toString() => "TaxonomyCategory(id: $id, type: $type, label: $label)";
}
