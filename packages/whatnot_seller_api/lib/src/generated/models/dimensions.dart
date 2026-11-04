// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: Dimensions
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "dimension_unit.dart" as _i1;

class Dimensions(
  /// The package length.
  final double length,

  /// The package width.
  final double width,

  /// The package height.
  final double height,

  /// The dimension unit.
  final _i1.DimensionUnit unit,
) {
  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    json["length"] as double,
    json["width"] as double,
    json["height"] as double,
    _i1.DimensionUnit.fromJson(json["unit"]),
  );

  Map<String, dynamic> toJson() => {
    "length": length,
    "width": width,
    "height": height,
    "unit": unit.toJson(),
  };
}
