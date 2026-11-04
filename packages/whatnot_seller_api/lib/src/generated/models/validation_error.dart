// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: ValidationError
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class ValidationError(
  final List<dynamic> loc,
  final String msg,
  final String type,
  final dynamic? input,
  final Map<String, dynamic>? ctx,
) {
  factory ValidationError.fromJson(Map<String, dynamic> json) =>
      ValidationError(
        (json["loc"] as List<dynamic>).map((e) => e as dynamic).toList(),
        json["msg"] as String,
        json["type"] as String,
        json["input"] as dynamic?,
        json["ctx"] as Map<String, dynamic>?,
      );

  Map<String, dynamic> toJson() => {
    "loc": loc,
    "msg": msg,
    "type": type,
    if (input != null) "input": input,
    if (ctx != null) "ctx": ctx,
  };
}
