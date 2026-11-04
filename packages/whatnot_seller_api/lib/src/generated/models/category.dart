// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: Category
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class Category(
  /// The category's id.
  final String id,

  /// The category's display name.
  final String? name,
) {
  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(json["id"] as String, json["name"] as String?);

  Map<String, dynamic> toJson() => {"id": id, if (name != null) "name": name};
}
