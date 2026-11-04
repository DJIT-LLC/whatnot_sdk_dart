// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ProductOption
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class ProductOption(
  /// The product option's id.
  final String? id,

  /// The option's display name, e.g. 'Color'.
  final String name,

  /// The option's values, e.g. ['Red', 'Blue'].
  final List<String> values,
) {
  factory ProductOption.fromJson(Map<String, dynamic> json) => ProductOption(
    json["id"] as String?,
    json["name"] as String,
    (json["values"] as List<dynamic>).map((e) => e as String).toList(),
  );

  Map<String, dynamic> toJson() => {
    if (id != null) "id": id,
    "name": name,
    "values": values,
  };
}
