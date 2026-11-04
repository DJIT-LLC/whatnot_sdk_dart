// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ShowAnalyticsStatus
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum ShowAnalyticsStatus {
  willNotBeCalculated("WILL_NOT_BE_CALCULATED"),
  notEnded("NOT_ENDED"),
  pending("PENDING"),
  generated("GENERATED");

  final String value;
  const ShowAnalyticsStatus(this.value);

  factory ShowAnalyticsStatus.fromJson(dynamic json) {
    return ShowAnalyticsStatus.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => ShowAnalyticsStatus.willNotBeCalculated,
    );
  }

  String toJson() => value;
}
