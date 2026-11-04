// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: DimensionProfile
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "weight.dart" as _i1;
import "dimensions.dart" as _i2;
import "dimension_profile_ownership.dart" as _i3;

/// A dimension profile, also embedded in products and shipment items.  On read, the resolved profile. On create, reference an existing profile by `id`, or supply `weight` and `dimensions` (with an optional `name`) to auto-create one.
class DimensionProfile(
  /// An existing dimension profile id to reference.
  final String? id,

  /// The dimension profile's name. When auto-creating a profile this is used as a name prefix, with the weight and dimensions appended.
  final String? name,

  /// The profile's per-item weight.
  final _i1.Weight? weight,

  /// The profile's package dimensions.
  final _i2.Dimensions? dimensions,

  /// Whether the dimension profile belongs to the seller or Whatnot.
  final _i3.DimensionProfileOwnership? ownership,

  /// Whether the dimension profile is active.
  final bool? active,
) {
  factory DimensionProfile.fromJson(Map<String, dynamic> json) =>
      DimensionProfile(
        json["id"] as String?,
        json["name"] as String?,
        json["weight"] != null
            ? _i1.Weight.fromJson(json["weight"] as Map<String, dynamic>)
            : null,
        json["dimensions"] != null
            ? _i2.Dimensions.fromJson(
                json["dimensions"] as Map<String, dynamic>,
              )
            : null,
        json["ownership"] != null
            ? _i3.DimensionProfileOwnership.fromJson(json["ownership"])
            : null,
        json["active"] as bool?,
      );

  Map<String, dynamic> toJson() => {
    if (id != null) "id": id,
    if (name != null) "name": name,
    if (weight != null) "weight": weight?.toJson(),
    if (dimensions != null) "dimensions": dimensions?.toJson(),
    if (ownership != null) "ownership": ownership?.toJson(),
    if (active != null) "active": active,
  };
}
