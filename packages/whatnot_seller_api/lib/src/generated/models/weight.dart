// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: Weight
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "weight_unit.dart" as _i1;

class Weight(
  /// The weight amount.
  final double value,

  /// The weight unit.
  final _i1.WeightUnit unit,
) {
  factory Weight.fromJson(Map<String, dynamic> json) =>
      Weight(json["value"] as double, _i1.WeightUnit.fromJson(json["unit"]));

  Map<String, dynamic> toJson() => {"value": value, "unit": unit.toJson()};
}
