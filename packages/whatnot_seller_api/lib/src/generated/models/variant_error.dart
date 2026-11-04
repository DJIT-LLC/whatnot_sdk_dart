// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: VariantError
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class VariantError(
  /// The patch's id, echoed from input.
  final String id,

  /// Why the patch was not applied.
  final String code,

  /// A human-readable explanation.
  final String message,
) {
  factory VariantError.fromJson(Map<String, dynamic> json) => VariantError(
    json["id"] as String,
    json["code"] as String,
    json["message"] as String,
  );

  Map<String, dynamic> toJson() => {"id": id, "code": code, "message": message};
}
