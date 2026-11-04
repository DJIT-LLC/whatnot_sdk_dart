// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: UpdateProductVariantsRequest
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "product_variant_patch.dart" as _i1;

class UpdateProductVariantsRequest(
  /// The variant patches, each keyed by id. At most 10 per request, and each id at most once.
  final List<_i1.ProductVariantPatch> variants,

  /// When true, valid variants are applied and failures are returned in errors. When false, any invalid variant rejects the whole batch with a 422 and nothing is written.
  final bool? allowPartialUpdates,
) {
  factory UpdateProductVariantsRequest.fromJson(Map<String, dynamic> json) =>
      UpdateProductVariantsRequest(
        (json["variants"] as List<dynamic>)
            .map(
              (e) =>
                  _i1.ProductVariantPatch.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        json["allow_partial_updates"] as bool?,
      );

  Map<String, dynamic> toJson() => {
    "variants": variants.map((e) => e.toJson()).toList(),
    if (allowPartialUpdates != null)
      "allow_partial_updates": allowPartialUpdates,
  };
}
