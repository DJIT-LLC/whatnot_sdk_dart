// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: VariantInventory
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class VariantInventory(
  /// Available inventory quantity.
  final int availableQuantity,
) {
  factory VariantInventory.fromJson(Map<String, dynamic> json) =>
      VariantInventory(json["available_quantity"] as int);

  Map<String, dynamic> toJson() => {"available_quantity": availableQuantity};
}
