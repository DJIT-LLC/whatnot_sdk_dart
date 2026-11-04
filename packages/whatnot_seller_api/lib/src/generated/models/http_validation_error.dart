// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: HTTPValidationError
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "validation_error.dart" as _i1;

class HTTPValidationError(final List<_i1.ValidationError>? detail) {
  factory HTTPValidationError.fromJson(Map<String, dynamic> json) =>
      HTTPValidationError(
        (json["detail"] as List<dynamic>?)
            ?.map(
              (e) => _i1.ValidationError.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    if (detail != null) "detail": detail?.map((e) => e.toJson()).toList(),
  };
}
