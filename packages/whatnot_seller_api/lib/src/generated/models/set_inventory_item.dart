// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: SetInventoryItem
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class SetInventoryItem(
  /// The variant's id.
  final String variantId,

  /// The available quantity to set.
  final int quantity,

  /// Caller-supplied key that makes this item idempotent: a retried item with the same key applies at most once and reports already_applied. Keys are scoped to the seller. Use a unique key for each distinct write, such as a V4 UUID.
  final String idempotencyKey,
) {
  factory SetInventoryItem.fromJson(Map<String, dynamic> json) =>
      SetInventoryItem(
        json["variant_id"] as String,
        json["quantity"] as int,
        json["idempotency_key"] as String,
      );

  Map<String, dynamic> toJson() => {
    "variant_id": variantId,
    "quantity": quantity,
    "idempotency_key": idempotencyKey,
  };
}
