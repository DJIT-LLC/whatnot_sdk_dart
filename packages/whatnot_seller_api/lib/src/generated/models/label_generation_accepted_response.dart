// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: LabelGenerationAcceptedResponse
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class LabelGenerationAcceptedResponse(
  /// Shipment whose label generation was requested.
  final String shipmentId,
) {
  factory LabelGenerationAcceptedResponse.fromJson(Map<String, dynamic> json) =>
      LabelGenerationAcceptedResponse(json["shipment_id"] as String);

  Map<String, dynamic> toJson() => {"shipment_id": shipmentId};
}
