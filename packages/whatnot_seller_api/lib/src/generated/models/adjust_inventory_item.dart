// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: AdjustInventoryItem
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class AdjustInventoryItem(
  /// The variant's id.
  final String variantId,

  /// The change to apply to the available quantity. A result below zero is floored at 0.
  final int delta,

  /// Caller-supplied key that makes this item idempotent: a retried item with the same key applies at most once and reports already_applied. Keys are scoped to the seller. Use a unique key for each distinct write, such as a V4 UUID.
  final String idempotencyKey,
) {
  factory AdjustInventoryItem.fromJson(Map<String, dynamic> json) =>
      AdjustInventoryItem(
        json["variant_id"] as String,
        json["delta"] as int,
        json["idempotency_key"] as String,
      );

  Map<String, dynamic> toJson() => {
    "variant_id": variantId,
    "delta": delta,
    "idempotency_key": idempotencyKey,
  };
}
