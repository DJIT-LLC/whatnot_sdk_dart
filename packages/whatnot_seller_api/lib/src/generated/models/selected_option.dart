// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: SelectedOption
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class SelectedOption(
  /// Stable product option identifier.
  final String id,

  /// Product option display name.
  final String name,

  /// Stable option value identifier.
  final String valueId,

  /// Selected option value.
  final String value,
) {
  factory SelectedOption.fromJson(Map<String, dynamic> json) => SelectedOption(
    json["id"] as String,
    json["name"] as String,
    json["value_id"] as String,
    json["value"] as String,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "value_id": valueId,
    "value": value,
  };
}
