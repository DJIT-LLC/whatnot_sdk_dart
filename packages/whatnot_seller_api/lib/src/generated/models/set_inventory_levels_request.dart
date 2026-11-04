// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: SetInventoryLevelsRequest
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "set_inventory_item.dart" as _i1;

class SetInventoryLevelsRequest(
  /// The variants to set, applied independently. At most 10 items per request.
  final List<_i1.SetInventoryItem> items,
) {
  factory SetInventoryLevelsRequest.fromJson(Map<String, dynamic> json) =>
      SetInventoryLevelsRequest(
        (json["items"] as List<dynamic>)
            .map(
              (e) => _i1.SetInventoryItem.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    "items": items.map((e) => e.toJson()).toList(),
  };
}
