// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: PageResponseOrder
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "order.dart" as _i1;

class PageResponseOrder(
  /// Results in the requested order.
  final List<_i1.Order> data,

  /// Continuation cursor; null when there are no more results.
  final String? nextCursor,
) {
  factory PageResponseOrder.fromJson(Map<String, dynamic> json) =>
      PageResponseOrder(
        (json["data"] as List<dynamic>)
            .map((e) => _i1.Order.fromJson(e as Map<String, dynamic>))
            .toList(),
        json["next_cursor"] as String?,
      );

  Map<String, dynamic> toJson() => {
    "data": data.map((e) => e.toJson()).toList(),
    if (nextCursor != null) "next_cursor": nextCursor,
  };
}
