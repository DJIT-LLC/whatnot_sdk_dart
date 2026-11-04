// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: UserSummary
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class UserSummary(
  /// The user's decimal ID.
  final String id,

  /// The user's username.
  final String username,

  /// The user's display name.
  final String? displayName,
) {
  factory UserSummary.fromJson(Map<String, dynamic> json) => UserSummary(
    json["id"] as String,
    json["username"] as String,
    json["display_name"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    if (displayName != null) "display_name": displayName,
  };
}
