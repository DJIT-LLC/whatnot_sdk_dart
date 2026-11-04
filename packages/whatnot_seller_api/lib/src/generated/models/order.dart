// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: Order
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "order_status.dart" as _i1;
import "order_transaction_type.dart" as _i2;
import "user_summary.dart" as _i3;
import "order_amounts.dart" as _i4;

class Order(
  /// The order's ID.
  final String id,

  /// The url of the order in the seller's dashboard.
  final String? url,

  /// The order's status. `pending` orders aren't ready to fulfill; fulfill `pending_fulfillment` orders.
  final _i1.OrderStatus status,

  /// The show the order was placed in; null for orders placed anywhere else.
  final String? showId,

  /// How the order was sold, if recorded. `other` covers retired formats.
  final _i2.OrderTransactionType? transactionType,

  /// The Whatnot user who placed the order; requires read:customers.
  final _i3.UserSummary? buyer,

  /// The order's monetary amounts.
  final _i4.OrderAmounts amounts,

  /// Creation timestamp, if recorded.
  final DateTime? createdAt,

  /// Last update timestamp, if recorded.
  final DateTime? updatedAt,

  /// When the order was cancelled, if it was.
  final DateTime? cancelledAt,
) {
  factory Order.fromJson(Map<String, dynamic> json) => Order(
    json["id"] as String,
    json["url"] as String?,
    _i1.OrderStatus.fromJson(json["status"]),
    json["show_id"] as String?,
    json["transaction_type"] != null
        ? _i2.OrderTransactionType.fromJson(json["transaction_type"])
        : null,
    json["buyer"] != null
        ? _i3.UserSummary.fromJson(json["buyer"] as Map<String, dynamic>)
        : null,
    _i4.OrderAmounts.fromJson(json["amounts"] as Map<String, dynamic>),
    json["created_at"] != null
        ? DateTime.parse(json["created_at"] as String)
        : null,
    json["updated_at"] != null
        ? DateTime.parse(json["updated_at"] as String)
        : null,
    json["cancelled_at"] != null
        ? DateTime.parse(json["cancelled_at"] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    if (url != null) "url": url,
    "status": status.toJson(),
    if (showId != null) "show_id": showId,
    if (transactionType != null) "transaction_type": transactionType?.toJson(),
    if (buyer != null) "buyer": buyer?.toJson(),
    "amounts": amounts.toJson(),
    if (createdAt != null) "created_at": createdAt?.toIso8601String(),
    if (updatedAt != null) "updated_at": updatedAt?.toIso8601String(),
    if (cancelledAt != null) "cancelled_at": cancelledAt?.toIso8601String(),
  };
}
