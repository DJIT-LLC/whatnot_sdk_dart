// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: AddTrackingCodeRequest
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class AddTrackingCodeRequest(
  /// The decimal IDs of the order items to ship under the tracking code.
  final List<String> orderItemIds,

  /// The carrier's tracking code for the package.
  final String trackingCode,

  /// The carrier delivering the package.
  final String carrier,
) {
  factory AddTrackingCodeRequest.fromJson(Map<String, dynamic> json) =>
      AddTrackingCodeRequest(
        (json["order_item_ids"] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        json["tracking_code"] as String,
        json["carrier"] as String,
      );

  Map<String, dynamic> toJson() => {
    "order_item_ids": orderItemIds,
    "tracking_code": trackingCode,
    "carrier": carrier,
  };
}
