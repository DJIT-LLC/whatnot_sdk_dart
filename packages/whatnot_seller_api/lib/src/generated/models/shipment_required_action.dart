// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ShipmentRequiredAction
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum ShipmentRequiredAction {
  countryOfOriginRequired("country_of_origin_required"),
  itnRequired("itn_required"),
  orderPendingCancellation("order_pending_cancellation"),
  packageReviewRequired("package_review_required");

  final String value;
  const ShipmentRequiredAction(this.value);

  factory ShipmentRequiredAction.fromJson(dynamic json) {
    return ShipmentRequiredAction.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => ShipmentRequiredAction.countryOfOriginRequired,
    );
  }

  String toJson() => value;
}
