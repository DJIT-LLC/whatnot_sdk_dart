/// Reference to an attribute associated with a category, including requirement status.
class CategoryAttributeRef(
  /// The ID of the associated attribute.
  final int id,

  /// Whether this attribute is mandatory when listing items in this category.
  final bool isRequired,
) {
  factory CategoryAttributeRef.fromJson(Map<String, dynamic> json) =>
      CategoryAttributeRef(
        (json["id"] as num).toInt(),
        json["is_required"] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {"id": id, "is_required": isRequired};

  @override
  String toString() => "CategoryAttributeRef(id: $id, isRequired: $isRequired)";
}
