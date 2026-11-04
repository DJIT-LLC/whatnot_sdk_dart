// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ShowStrategy
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
/// The public, user-facing values for reconciling a product's shows.
enum ShowStrategy {
  add("ADD"),
  remove("REMOVE"),
  replace("REPLACE");

  final String value;
  const ShowStrategy(this.value);

  factory ShowStrategy.fromJson(dynamic json) {
    return ShowStrategy.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => ShowStrategy.add,
    );
  }

  String toJson() => value;
}
