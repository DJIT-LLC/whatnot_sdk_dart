// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: DimensionUnit
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum DimensionUnit {
  inch("inch"),
  feet("feet"),
  centimeter("centimeter"),
  meter("meter");

  final String value;
  const DimensionUnit(this.value);

  factory DimensionUnit.fromJson(dynamic json) {
    return DimensionUnit.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => DimensionUnit.inch,
    );
  }

  String toJson() => value;
}
