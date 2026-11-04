// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: SpecificShows
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class SpecificShows(
  /// The shows to report on, in the order their rows appear. Every show must be hosted by the seller.
  final List<String> showIds,
) {
  factory SpecificShows.fromJson(Map<String, dynamic> json) => SpecificShows(
    (json["show_ids"] as List<dynamic>).map((e) => e as String).toList(),
  );

  Map<String, dynamic> toJson() => {"show_ids": showIds};
}
