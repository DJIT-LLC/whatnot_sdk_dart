// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ShowVisibility
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum ShowVisibility {
  public("public"),
  private("private");

  final String value;
  const ShowVisibility(this.value);

  factory ShowVisibility.fromJson(dynamic json) {
    return ShowVisibility.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => ShowVisibility.public,
    );
  }

  String toJson() => value;
}
