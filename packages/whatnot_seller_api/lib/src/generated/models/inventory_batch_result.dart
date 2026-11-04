// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: InventoryBatchResult
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "inventory_result.dart" as _i1;

class InventoryBatchResult(
  /// Per-item results, in the same order as the input items.
  final List<_i1.InventoryResult> results,
) {
  factory InventoryBatchResult.fromJson(Map<String, dynamic> json) =>
      InventoryBatchResult(
        (json["results"] as List<dynamic>)
            .map((e) => _i1.InventoryResult.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    "results": results.map((e) => e.toJson()).toList(),
  };
}
