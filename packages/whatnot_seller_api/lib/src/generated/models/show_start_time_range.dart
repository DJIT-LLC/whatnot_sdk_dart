// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ShowStartTimeRange
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class ShowStartTimeRange(
  /// Include only shows that started at or after this time.
  final DateTime start,

  /// Include only shows that started at or before this time. Defaults to the end of the current hour.
  final DateTime? end,
) {
  factory ShowStartTimeRange.fromJson(Map<String, dynamic> json) =>
      ShowStartTimeRange(
        DateTime.parse(json["start"] as String),
        json["end"] != null ? DateTime.parse(json["end"] as String) : null,
      );

  Map<String, dynamic> toJson() => {
    "start": start.toIso8601String(),
    if (end != null) "end": end?.toIso8601String(),
  };
}
