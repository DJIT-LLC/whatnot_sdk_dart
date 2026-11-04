// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ShipmentStatus
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
enum ShipmentStatus {
  created("created"),
  labelGenerated("label_generated"),
  droppedOff("dropped_off"),
  inTransit("in_transit"),
  delivered("delivered"),
  failed("failed"),
  cancelled("cancelled"),
  cancelledNotShipped("cancelled_not_shipped"),
  cancelledNotShippedWithDropoff("cancelled_not_shipped_with_dropoff"),
  cancelledTrackingStuck("cancelled_tracking_stuck");

  final String value;
  const ShipmentStatus(this.value);

  factory ShipmentStatus.fromJson(dynamic json) {
    return ShipmentStatus.values.firstWhere(
      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),
      orElse: () => ShipmentStatus.created,
    );
  }

  String toJson() => value;
}
