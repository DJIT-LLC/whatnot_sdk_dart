// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ReportStatus
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum ReportStatus {
  pending("pending"),
  inProgress("in_progress"),
  completed("completed"),
  failed("failed"),
  cancelled("cancelled");

  final String value;
  const ReportStatus(this.value);

  factory ReportStatus.fromJson(dynamic json) {
    return ReportStatus.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => ReportStatus.pending,
    );
  }

  String toJson() => value;
}
