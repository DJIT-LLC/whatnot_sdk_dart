// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: PurchasedItem
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class PurchasedItem(
  /// The item's title when it was purchased.
  final String title,

  /// The item's description when it was purchased, if set.
  final String? description,

  /// The item's SKU when it was purchased, if set.
  final String? sku,
) {
  factory PurchasedItem.fromJson(Map<String, dynamic> json) => PurchasedItem(
    json["title"] as String,
    json["description"] as String?,
    json["sku"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    if (description != null) "description": description,
    if (sku != null) "sku": sku,
  };
}
