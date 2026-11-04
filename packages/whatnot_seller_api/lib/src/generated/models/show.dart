// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: Show
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "show_status.dart" as _i1;
import "show_visibility.dart" as _i2;
import "media.dart" as _i3;

class Show(
  /// The show's ID.
  final String id,

  /// The show's title.
  final String title,

  /// The url of the show in the seller's dashboard.
  final String url,

  /// The show's description, if set.
  final String? description,

  /// The show's lifecycle status. A stopped show can resume; an ended show cannot.
  final _i1.ShowStatus status,

  /// Whether the show is visible to everyone or only to invited viewers.
  final _i2.ShowVisibility visibility,

  /// When the show is scheduled to start. Not updated when the show goes live.
  final DateTime? scheduledStartAt,

  /// When the show ended, if it has.
  final DateTime? endedAt,

  /// The show's thumbnail image, if set.
  final _i3.Media? thumbnail,

  /// Creation timestamp.
  final DateTime createdAt,

  /// Last update timestamp.
  final DateTime updatedAt,
) {
  factory Show.fromJson(Map<String, dynamic> json) => Show(
    json["id"] as String,
    json["title"] as String,
    json["url"] as String,
    json["description"] as String?,
    _i1.ShowStatus.fromJson(json["status"]),
    _i2.ShowVisibility.fromJson(json["visibility"]),
    json["scheduled_start_at"] != null
        ? DateTime.parse(json["scheduled_start_at"] as String)
        : null,
    json["ended_at"] != null
        ? DateTime.parse(json["ended_at"] as String)
        : null,
    json["thumbnail"] != null
        ? _i3.Media.fromJson(json["thumbnail"] as Map<String, dynamic>)
        : null,
    DateTime.parse(json["created_at"] as String),
    DateTime.parse(json["updated_at"] as String),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    if (description != null) "description": description,
    "status": status.toJson(),
    "visibility": visibility.toJson(),
    if (scheduledStartAt != null)
      "scheduled_start_at": scheduledStartAt?.toIso8601String(),
    if (endedAt != null) "ended_at": endedAt?.toIso8601String(),
    if (thumbnail != null) "thumbnail": thumbnail?.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
