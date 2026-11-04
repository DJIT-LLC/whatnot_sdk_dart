// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: AdjustInventoryLevelsRequest
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "adjust_inventory_item.dart" as _i1;

class AdjustInventoryLevelsRequest(
  /// The variants to adjust, applied independently. At most 10 items per request.
  final List<_i1.AdjustInventoryItem> items,
) {
  factory AdjustInventoryLevelsRequest.fromJson(Map<String, dynamic> json) =>
      AdjustInventoryLevelsRequest(
        (json["items"] as List<dynamic>)
            .map(
              (e) =>
                  _i1.AdjustInventoryItem.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    "items": items.map((e) => e.toJson()).toList(),
  };
}
