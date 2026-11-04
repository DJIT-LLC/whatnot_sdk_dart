// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: RootResponse
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class RootResponse(
  /// Current API status.
  final String status,
) {
  factory RootResponse.fromJson(Map<String, dynamic> json) =>
      RootResponse(json["status"] as String);

  Map<String, dynamic> toJson() => {"status": status};
}
