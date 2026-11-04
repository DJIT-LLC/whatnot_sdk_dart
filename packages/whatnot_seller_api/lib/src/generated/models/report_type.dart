// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ReportType
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum ReportType {
  sellerFinancialReport("seller_financial_report"),
  analyticsOverviewReport("analytics_overview_report"),
  analyticsLivestreamsReport("analytics_livestreams_report");

  final String value;
  const ReportType(this.value);

  factory ReportType.fromJson(dynamic json) {
    return ReportType.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => ReportType.sellerFinancialReport,
    );
  }

  String toJson() => value;
}
