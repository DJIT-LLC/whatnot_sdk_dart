// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: CancelOrderRequest
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "order_cancellation_reason.dart" as _i1;

class CancelOrderRequest(
  /// The reason for cancelling the order. `break_did_not_fill` is accepted only for orders from a break.
  final _i1.OrderCancellationReason reason,
) {
  factory CancelOrderRequest.fromJson(Map<String, dynamic> json) =>
      CancelOrderRequest(_i1.OrderCancellationReason.fromJson(json["reason"]));

  Map<String, dynamic> toJson() => {"reason": reason.toJson()};
}
