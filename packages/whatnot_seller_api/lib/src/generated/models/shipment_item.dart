// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ShipmentItem
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "dimension_profile.dart" as _i1;
import "hazardous_material.dart" as _i2;

class ShipmentItem(
  /// The shipment item's ID; distinct from its order-item ID.
  final String id,

  /// The ID of the shipment currently containing this item.
  final String shipmentId,

  /// The ID of the order associated with this item, if available.
  final String? orderId,

  /// The ID of the order item associated with this shipment item, if available.
  final String? orderItemId,

  /// The item's dimension profile, if available.
  final _i1.DimensionProfile? dimensionProfile,

  /// The hazardous-material classification of this item.
  final _i2.HazardousMaterial? hazardousMaterial,

  /// Country of origin, if recorded.
  final String? countryOfOrigin,

  /// Creation timestamp, if recorded.
  final DateTime? createdAt,

  /// Last update timestamp, if recorded.
  final DateTime? updatedAt,
) {
  factory ShipmentItem.fromJson(Map<String, dynamic> json) => ShipmentItem(
    json["id"] as String,
    json["shipment_id"] as String,
    json["order_id"] as String?,
    json["order_item_id"] as String?,
    json["dimension_profile"] != null
        ? _i1.DimensionProfile.fromJson(
            json["dimension_profile"] as Map<String, dynamic>,
          )
        : null,
    json["hazardous_material"] != null
        ? _i2.HazardousMaterial.fromJson(json["hazardous_material"])
        : null,
    json["country_of_origin"] as String?,
    json["created_at"] != null
        ? DateTime.parse(json["created_at"] as String)
        : null,
    json["updated_at"] != null
        ? DateTime.parse(json["updated_at"] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shipment_id": shipmentId,
    if (orderId != null) "order_id": orderId,
    if (orderItemId != null) "order_item_id": orderItemId,
    if (dimensionProfile != null)
      "dimension_profile": dimensionProfile?.toJson(),
    if (hazardousMaterial != null)
      "hazardous_material": hazardousMaterial?.toJson(),
    if (countryOfOrigin != null) "country_of_origin": countryOfOrigin,
    if (createdAt != null) "created_at": createdAt?.toIso8601String(),
    if (updatedAt != null) "updated_at": updatedAt?.toIso8601String(),
  };
}
