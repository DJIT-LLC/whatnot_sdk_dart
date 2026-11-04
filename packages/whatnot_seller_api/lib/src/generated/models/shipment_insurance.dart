// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ShipmentInsurance
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "money.dart" as _i1;

class ShipmentInsurance(
  /// Insured value.
  final _i1.Money amount,

  /// Description of insured contents.
  final String? contents,
) {
  factory ShipmentInsurance.fromJson(Map<String, dynamic> json) =>
      ShipmentInsurance(
        _i1.Money.fromJson(json["amount"] as Map<String, dynamic>),
        json["contents"] as String?,
      );

  Map<String, dynamic> toJson() => {
    "amount": amount.toJson(),
    if (contents != null) "contents": contents,
  };
}
