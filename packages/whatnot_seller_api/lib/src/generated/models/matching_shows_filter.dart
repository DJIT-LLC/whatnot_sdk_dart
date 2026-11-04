// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: MatchingShowsFilter
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "show_start_time_range.dart" as _i1;

/// Which of the seller's shows an `all_matching` report covers.
class MatchingShowsFilter(
  /// Include only shows whose title matches this text.
  final String? title,

  /// Include only shows that started within this range.
  final _i1.ShowStartTimeRange? startTime,
) {
  factory MatchingShowsFilter.fromJson(Map<String, dynamic> json) =>
      MatchingShowsFilter(
        json["title"] as String?,
        json["start_time"] != null
            ? _i1.ShowStartTimeRange.fromJson(
                json["start_time"] as Map<String, dynamic>,
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
    if (title != null) "title": title,
    if (startTime != null) "start_time": startTime?.toJson(),
  };
}
