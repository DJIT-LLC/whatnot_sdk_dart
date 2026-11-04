// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: DimensionProfileOwnership
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum DimensionProfileOwnership {
  seller("seller"),
  whatnot("whatnot");

  final String value;
  const DimensionProfileOwnership(this.value);

  factory DimensionProfileOwnership.fromJson(dynamic json) {
    return DimensionProfileOwnership.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => DimensionProfileOwnership.seller,
    );
  }

  String toJson() => value;
}
