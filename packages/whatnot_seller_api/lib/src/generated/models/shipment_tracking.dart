// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ShipmentTracking
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class ShipmentTracking(
  /// The carrier delivering this shipment.
  final String? carrier,

  /// The carrier service used for this shipment.
  final String? service,

  /// The carrier's tracking code for this shipment.
  final String? trackingCode,

  /// The tracking code used for the final leg of delivery.
  final String? lastMileTrackingCode,
) {
  factory ShipmentTracking.fromJson(Map<String, dynamic> json) =>
      ShipmentTracking(
        json["carrier"] as String?,
        json["service"] as String?,
        json["tracking_code"] as String?,
        json["last_mile_tracking_code"] as String?,
      );

  Map<String, dynamic> toJson() => {
    if (carrier != null) "carrier": carrier,
    if (service != null) "service": service,
    if (trackingCode != null) "tracking_code": trackingCode,
    if (lastMileTrackingCode != null)
      "last_mile_tracking_code": lastMileTrackingCode,
  };
}
