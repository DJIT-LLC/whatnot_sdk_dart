// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: Media
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
class Media(
  /// The image's id.
  final String? id,

  /// On create, the image URL to ingest. On read, the CDN URL of the ingested image.
  final String url,

  /// The image's alt text / label, if set.
  final String? alt,
) {
  factory Media.fromJson(Map<String, dynamic> json) => Media(
    json["id"] as String?,
    json["url"] as String,
    json["alt"] as String?,
  );

  Map<String, dynamic> toJson() => {
    if (id != null) "id": id,
    "url": url,
    if (alt != null) "alt": alt,
  };
}
