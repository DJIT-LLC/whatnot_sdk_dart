// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: Shipment
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "shipment_status.dart" as _i1;
import "fulfillment_method.dart" as _i2;
import "user_summary.dart" as _i3;
import "weight.dart" as _i4;
import "dimensions.dart" as _i5;
import "hazardous_material.dart" as _i6;
import "shipment_tracking.dart" as _i7;
import "shipment_documents.dart" as _i8;
import "shipment_insurance.dart" as _i9;
import "money.dart" as _i10;
import "shipment_required_action.dart" as _i11;

class Shipment(
  /// The shipment's ID.
  final String id,

  /// The url of the shipment in the seller's dashboard.
  final String url,

  /// The current fulfillment status of this shipment.
  final _i1.ShipmentStatus status,

  /// The method of fulfillment for this shipment.
  final _i2.FulfillmentMethod fulfillmentMethod,

  /// The Whatnot user receiving this shipment; requires read:customers.
  final _i3.UserSummary? recipient,

  /// Package weight, if known and valid.
  final _i4.Weight? weight,

  /// Package dimensions, if known and valid.
  final _i5.Dimensions? dimensions,

  /// Whether delivery requires a signature.
  final bool signatureRequired,

  /// The hazardous-material classification of this shipment's contents.
  final _i6.HazardousMaterial? hazardousMaterial,

  /// Carrier and tracking information.
  final _i7.ShipmentTracking? tracking,

  /// The shipping documents available for this shipment; requires read:customers.
  final _i8.ShipmentDocuments? documents,

  /// Shipping insurance, if present.
  final _i9.ShipmentInsurance? insurance,

  /// The seller's share of shipping across this shipment's active orders, set at checkout by the seller's shipping settings. Not the label's purchase price, and excludes later carrier adjustments. Null when none was recorded.
  final _i10.Money? sellerPaidShippingCost,

  /// Actions required before fulfillment.
  final List<_i11.ShipmentRequiredAction> requiredActions,

  /// Due date at seller-local midnight, serialized with timezone; not the overdue cutoff. Null for pickup, non-pre-transit shipments, or missing inputs.
  final DateTime? dropoffDue,

  /// Immediate successor shipment ID after replacement, bundling, or splitting; not the final successor in a chain.
  final String? replacementShipmentId,

  /// Creation timestamp, if recorded.
  final DateTime? createdAt,

  /// Last update timestamp, if recorded.
  final DateTime? updatedAt,
) {
  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
    json["id"] as String,
    json["url"] as String,
    _i1.ShipmentStatus.fromJson(json["status"]),
    _i2.FulfillmentMethod.fromJson(json["fulfillment_method"]),
    json["recipient"] != null
        ? _i3.UserSummary.fromJson(json["recipient"] as Map<String, dynamic>)
        : null,
    json["weight"] != null
        ? _i4.Weight.fromJson(json["weight"] as Map<String, dynamic>)
        : null,
    json["dimensions"] != null
        ? _i5.Dimensions.fromJson(json["dimensions"] as Map<String, dynamic>)
        : null,
    json["signature_required"] as bool,
    json["hazardous_material"] != null
        ? _i6.HazardousMaterial.fromJson(json["hazardous_material"])
        : null,
    json["tracking"] != null
        ? _i7.ShipmentTracking.fromJson(
            json["tracking"] as Map<String, dynamic>,
          )
        : null,
    json["documents"] != null
        ? _i8.ShipmentDocuments.fromJson(
            json["documents"] as Map<String, dynamic>,
          )
        : null,
    json["insurance"] != null
        ? _i9.ShipmentInsurance.fromJson(
            json["insurance"] as Map<String, dynamic>,
          )
        : null,
    json["seller_paid_shipping_cost"] != null
        ? _i10.Money.fromJson(
            json["seller_paid_shipping_cost"] as Map<String, dynamic>,
          )
        : null,
    (json["required_actions"] as List<dynamic>)
        .map(
          (e) =>
              _i11.ShipmentRequiredAction.fromJson(e as Map<String, dynamic>),
        )
        .toList(),
    json["dropoff_due"] != null
        ? DateTime.parse(json["dropoff_due"] as String)
        : null,
    json["replacement_shipment_id"] as String?,
    json["created_at"] != null
        ? DateTime.parse(json["created_at"] as String)
        : null,
    json["updated_at"] != null
        ? DateTime.parse(json["updated_at"] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "status": status.toJson(),
    "fulfillment_method": fulfillmentMethod.toJson(),
    if (recipient != null) "recipient": recipient?.toJson(),
    if (weight != null) "weight": weight?.toJson(),
    if (dimensions != null) "dimensions": dimensions?.toJson(),
    "signature_required": signatureRequired,
    if (hazardousMaterial != null)
      "hazardous_material": hazardousMaterial?.toJson(),
    if (tracking != null) "tracking": tracking?.toJson(),
    if (documents != null) "documents": documents?.toJson(),
    if (insurance != null) "insurance": insurance?.toJson(),
    if (sellerPaidShippingCost != null)
      "seller_paid_shipping_cost": sellerPaidShippingCost?.toJson(),
    "required_actions": requiredActions.map((e) => e.toJson()).toList(),
    if (dropoffDue != null) "dropoff_due": dropoffDue?.toIso8601String(),
    if (replacementShipmentId != null)
      "replacement_shipment_id": replacementShipmentId,
    if (createdAt != null) "created_at": createdAt?.toIso8601String(),
    if (updatedAt != null) "updated_at": updatedAt?.toIso8601String(),
  };
}
