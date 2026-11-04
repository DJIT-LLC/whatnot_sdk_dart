// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: Report
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "report_type.dart" as _i1;
import "report_status.dart" as _i2;

/// One asynchronous report generation run.  Runs are created `pending`; generation happens asynchronously.
class Report(
  /// The report run's ID.
  final String id,

  /// The type of report this run generates.
  final _i1.ReportType reportType,

  /// The status of the run.
  final _i2.ReportStatus status,

  /// The parameters this run covers, after defaults were applied. The shape depends on `report_type`. Null when the run has no parameters.
  final dynamic? reportParameters,

  /// URL of the generated report file. Null until the run is `completed`. See [Reports and Statements](/reports) for each report type's CSV columns.
  final String? reportUrl,

  /// When the run was requested.
  final DateTime createdAt,

  /// When the run was last updated.
  final DateTime updatedAt,
) {
  factory Report.fromJson(Map<String, dynamic> json) => Report(
    json["id"] as String,
    _i1.ReportType.fromJson(json["report_type"]),
    _i2.ReportStatus.fromJson(json["status"]),
    json["report_parameters"] as dynamic?,
    json["report_url"] as String?,
    DateTime.parse(json["created_at"] as String),
    DateTime.parse(json["updated_at"] as String),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "report_type": reportType.toJson(),
    "status": status.toJson(),
    if (reportParameters != null) "report_parameters": reportParameters,
    if (reportUrl != null) "report_url": reportUrl,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
