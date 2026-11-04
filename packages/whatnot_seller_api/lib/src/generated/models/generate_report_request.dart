// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: GenerateReportRequest
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class GenerateReportRequest(
  /// The parameters of the report to generate. `report_type` selects the kind of report and the other fields it accepts.
  final dynamic reportParameters,
) {
  factory GenerateReportRequest.fromJson(Map<String, dynamic> json) =>
      GenerateReportRequest(json["report_parameters"] as dynamic);

  Map<String, dynamic> toJson() => {"report_parameters": reportParameters};
}
