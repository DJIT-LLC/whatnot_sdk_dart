// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ShipmentDocuments
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class ShipmentDocuments(
  /// Shipping label URL, if available. Usually hosted by the label provider, which sets how long it stays valid.
  final String? labelUrl,

  /// Combined label and packing slip, or pickup slip URL. This presigned URL is valid for up to 1 hour; re-fetch the shipment with `GET /shipments/{shipment_id}` for a fresh link.
  final String? bundledUrl,

  /// Commercial invoice URL from the label provider, if one was issued.
  final String? commercialInvoiceUrl,
) {
  factory ShipmentDocuments.fromJson(Map<String, dynamic> json) =>
      ShipmentDocuments(
        json["label_url"] as String?,
        json["bundled_url"] as String?,
        json["commercial_invoice_url"] as String?,
      );

  Map<String, dynamic> toJson() => {
    if (labelUrl != null) "label_url": labelUrl,
    if (bundledUrl != null) "bundled_url": bundledUrl,
    if (commercialInvoiceUrl != null)
      "commercial_invoice_url": commercialInvoiceUrl,
  };
}
