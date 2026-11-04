// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: InventoryResult
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class InventoryResult(
  /// The item's variant_id, echoed from input.
  final String variantId,

  /// The item's idempotency_key, echoed from input.
  final String idempotencyKey,

  /// What happened to this item.
  final String status,

  /// The available quantity just before this item applied.
  final int? previousQuantity,

  /// The available quantity after this item.
  final int? newQuantity,

  /// Non-fatal conditions observed while applying this item.
  final List<String> warnings,
) {
  factory InventoryResult.fromJson(Map<String, dynamic> json) =>
      InventoryResult(
        json["variant_id"] as String,
        json["idempotency_key"] as String,
        json["status"] as String,
        json["previous_quantity"] as int?,
        json["new_quantity"] as int?,
        (json["warnings"] as List<dynamic>).map((e) => e as String).toList(),
      );

  Map<String, dynamic> toJson() => {
    "variant_id": variantId,
    "idempotency_key": idempotencyKey,
    "status": status,
    if (previousQuantity != null) "previous_quantity": previousQuantity,
    if (newQuantity != null) "new_quantity": newQuantity,
    "warnings": warnings,
  };
}
