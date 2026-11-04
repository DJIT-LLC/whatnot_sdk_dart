// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated model: VariantBatchResult
// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes
import "product_variant.dart" as _i1;
import "variant_error.dart" as _i2;

class VariantBatchResult(
  /// The updated variants, in input order.
  final List<_i1.ProductVariant> variants,

  /// Patches that were not applied, in input order. Present only when allow_partial_updates is true.
  final List<_i2.VariantError>? errors,
) {
  factory VariantBatchResult.fromJson(Map<String, dynamic> json) =>
      VariantBatchResult(
        (json["variants"] as List<dynamic>)
            .map((e) => _i1.ProductVariant.fromJson(e as Map<String, dynamic>))
            .toList(),
        (json["errors"] as List<dynamic>?)
            ?.map((e) => _i2.VariantError.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    "variants": variants.map((e) => e.toJson()).toList(),
    if (errors != null) "errors": errors?.map((e) => e.toJson()).toList(),
  };
}
