// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ShowsInput
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "show_strategy.dart" as _i1;

/// The requested change to which shows a product appears in.
class ShowsInput(
  /// ADD leaves the product's other shows untouched and adds these; REMOVE takes it off these shows; REPLACE makes these the product's only shows, removing it from any others.
  final _i1.ShowStrategy strategy,

  /// The shows to add or remove, by show ID. For replace, the product's complete set of shows after the call; an empty list removes it from every show.
  final List<String> showIds,
) {
  factory ShowsInput.fromJson(Map<String, dynamic> json) => ShowsInput(
    _i1.ShowStrategy.fromJson(json["strategy"]),
    (json["show_ids"] as List<dynamic>).map((e) => e as String).toList(),
  );

  Map<String, dynamic> toJson() => {
    "strategy": strategy.toJson(),
    "show_ids": showIds,
  };
}
