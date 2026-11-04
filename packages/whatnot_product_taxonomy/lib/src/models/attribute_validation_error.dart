/// Represents a validation error when checking product attributes against taxonomy rules.
class AttributeValidationError(
  /// The attribute key that caused the validation issue.
  final String attributeKey,

  /// Detailed explanation of the error.
  final String message, {

  /// Whether the error was due to a missing mandatory attribute.
  final bool isMissingRequired = false,

  /// Whether the value was outside allowed options.
  final bool isInvalidValue = false,

  /// Whether the data type did not match the expected type.
  final bool isTypeMismatch = false,
}) {
  @override
  String toString() => "AttributeValidationError($attributeKey: $message)";
}
