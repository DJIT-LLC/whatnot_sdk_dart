// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: OrderAmounts
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "money.dart" as _i1;

class OrderAmounts(
  /// The price of the items ordered.
  final _i1.Money subtotal,

  /// Shipping charged to the buyer.
  final _i1.Money shipping,

  /// Tax charged to the buyer.
  final _i1.Money tax,

  /// The discount from the seller's coupon; null when none applied or the coupon isn't the seller's.
  final dynamic? appliedDiscount,

  /// The total the buyer paid.
  final _i1.Money total,
) {
  factory OrderAmounts.fromJson(Map<String, dynamic> json) => OrderAmounts(
    _i1.Money.fromJson(json["subtotal"] as Map<String, dynamic>),
    _i1.Money.fromJson(json["shipping"] as Map<String, dynamic>),
    _i1.Money.fromJson(json["tax"] as Map<String, dynamic>),
    json["applied_discount"] as dynamic?,
    _i1.Money.fromJson(json["total"] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "subtotal": subtotal.toJson(),
    "shipping": shipping.toJson(),
    "tax": tax.toJson(),
    if (appliedDiscount != null) "applied_discount": appliedDiscount,
    "total": total.toJson(),
  };
}
