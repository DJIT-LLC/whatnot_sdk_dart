/// Envelope model for Whatnot incoming webhook deliveries.
class WebhookEvent<T>(
  /// The unique ID of the webhook event, used for idempotency.
  final String id,

  /// The timestamp when the webhook event was generated.
  final DateTime timestamp,

  /// The event topic (e.g. `order/created`, `product/sold`).
  final String topic,

  /// The strongly-typed payload object.
  final T object,
) {
  /// Deserializes a webhook JSON payload into a typed [WebhookEvent].
  factory WebhookEvent.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic raw) parseObject,
  ) {
    return WebhookEvent(
      json["id"] as String? ?? "",
      json["timestamp"] != null
          ? DateTime.parse(json["timestamp"] as String)
          : DateTime.now().toUtc(),
      json["topic"] as String? ?? "",
      parseObject(json["object"]),
    );
  }

  @override
  String toString() =>
      "WebhookEvent(id: $id, topic: $topic, timestamp: $timestamp, object: $object)";
}
