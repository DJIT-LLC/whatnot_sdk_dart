// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ShowStatus
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum ShowStatus {
  scheduled("scheduled"),
  live("live"),
  stopped("stopped"),
  ended("ended"),
  cancelled("cancelled");

  final String value;
  const ShowStatus(this.value);

  factory ShowStatus.fromJson(dynamic json) {
    return ShowStatus.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => ShowStatus.scheduled,
    );
  }

  String toJson() => value;
}
