// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: FinancialReportParameters
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
/// Parameters for a `seller_financial_report` run.
class FinancialReportParameters(
  /// The type of report these parameters describe.
  final String reportType,

  /// Include only transactions completed at or after this time. Defaults to one week before `end_date`.
  final DateTime? startDate,

  /// Include only transactions completed before this time. Defaults to one week after `start_date`, or to the current hour when neither end is given.
  final DateTime? endDate,
) {
  factory FinancialReportParameters.fromJson(Map<String, dynamic> json) =>
      FinancialReportParameters(
        json["report_type"] as String,
        json["start_date"] != null
            ? DateTime.parse(json["start_date"] as String)
            : null,
        json["end_date"] != null
            ? DateTime.parse(json["end_date"] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
    "report_type": reportType,
    if (startDate != null) "start_date": startDate?.toIso8601String(),
    if (endDate != null) "end_date": endDate?.toIso8601String(),
  };
}
