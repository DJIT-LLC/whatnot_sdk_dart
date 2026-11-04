// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: FulfillmentMethod
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum FulfillmentMethod {
  shipping("shipping"),
  pickup("pickup");

  final String value;
  const FulfillmentMethod(this.value);

  factory FulfillmentMethod.fromJson(dynamic json) {
    return FulfillmentMethod.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => FulfillmentMethod.shipping,
    );
  }

  String toJson() => value;
}
