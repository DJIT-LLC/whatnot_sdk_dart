// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: WeightUnit
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
/// The unit used to express weight.
enum WeightUnit {
  ounce("ounce"),
  pound("pound"),
  gram("gram"),
  kilogram("kilogram");

  final String value;
  const WeightUnit(this.value);

  factory WeightUnit.fromJson(dynamic json) {
    return WeightUnit.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => WeightUnit.ounce,
    );
  }

  String toJson() => value;
}
