// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: HazardousMaterial
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum HazardousMaterial {
  notHazardous("not_hazardous"),
  standard("standard"),
  lithiumBattery("lithium_battery");

  final String value;
  const HazardousMaterial(this.value);

  factory HazardousMaterial.fromJson(dynamic json) {
    return HazardousMaterial.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => HazardousMaterial.notHazardous,
    );
  }

  String toJson() => value;
}
