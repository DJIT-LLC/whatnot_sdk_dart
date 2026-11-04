// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: AnalyticsOverviewReportParameters
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
/// Parameters for an `analytics_overview_report` run.  The report is one row per calendar day of the window.
class AnalyticsOverviewReportParameters(
  /// The type of report these parameters describe.
  final String reportType,

  /// The start of the reported window.
  final DateTime startAt,

  /// The end of the reported window. Must be after `start_at`.
  final DateTime endAt,
) {
  factory AnalyticsOverviewReportParameters.fromJson(
    Map<String, dynamic> json,
  ) => AnalyticsOverviewReportParameters(
    json["report_type"] as String,
    DateTime.parse(json["start_at"] as String),
    DateTime.parse(json["end_at"] as String),
  );

  Map<String, dynamic> toJson() => {
    "report_type": reportType,
    "start_at": startAt.toIso8601String(),
    "end_at": endAt.toIso8601String(),
  };
}
