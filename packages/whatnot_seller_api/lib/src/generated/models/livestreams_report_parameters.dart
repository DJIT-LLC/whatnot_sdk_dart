// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: LivestreamsReportParameters
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "matching_shows_filter.dart" as _i1;
import "specific_shows.dart" as _i2;

/// Parameters for an `analytics_livestreams_report` run.  Exactly one of `all_matching` and `specific_shows` selects the shows.
class LivestreamsReportParameters(
  /// The type of report these parameters describe.
  final String reportType,

  /// Report on every show matching the filter, most recently started first. An empty filter covers all of the seller's shows.
  final _i1.MatchingShowsFilter? allMatching,

  /// Report on exactly these shows.
  final _i2.SpecificShows? specificShows,
) {
  factory LivestreamsReportParameters.fromJson(Map<String, dynamic> json) =>
      LivestreamsReportParameters(
        json["report_type"] as String,
        json["all_matching"] != null
            ? _i1.MatchingShowsFilter.fromJson(
                json["all_matching"] as Map<String, dynamic>,
              )
            : null,
        json["specific_shows"] != null
            ? _i2.SpecificShows.fromJson(
                json["specific_shows"] as Map<String, dynamic>,
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
    "report_type": reportType,
    if (allMatching != null) "all_matching": allMatching?.toJson(),
    if (specificShows != null) "specific_shows": specificShows?.toJson(),
  };
}
