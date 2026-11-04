import "generated/taxonomy_data.dart";
import "models/attribute_validation_error.dart";
import "models/taxonomy_attribute.dart";
import "models/taxonomy_category.dart";

/// Central query, discovery, and validation engine for Whatnot product categories and attributes.
class WhatnotTaxonomy {
  /// The global singleton instance of the taxonomy.
  static final WhatnotTaxonomy instance = WhatnotTaxonomy._();

  final Map<int, TaxonomyCategory> _categoriesById;
  final Map<String, TaxonomyCategory> _categoriesByType;
  final Map<int, TaxonomyAttribute> _attributesById;
  final Map<String, TaxonomyAttribute> _attributesByKey;

  WhatnotTaxonomy._()
    : _categoriesById = {for (final c in kTaxonomyCategories) c.id: c},
      _categoriesByType = {
        for (final c in kTaxonomyCategories) c.type.toLowerCase(): c,
      },
      _attributesById = {for (final a in kTaxonomyAttributes) a.id: a},
      _attributesByKey = {
        for (final a in kTaxonomyAttributes) a.key.toLowerCase(): a,
      };

  /// The version of the underlying taxonomy dataset.
  String get version => kTaxonomyVersion;

  /// All 350+ marketplace categories.
  List<TaxonomyCategory> get allCategories => kTaxonomyCategories;

  /// All 440+ attribute specifications.
  List<TaxonomyAttribute> get allAttributes => kTaxonomyAttributes;

  /// Retrieves a category by its numeric [id].
  TaxonomyCategory? getCategory(int id) => _categoriesById[id];

  /// Finds a category by its machine slug [type] (e.g. `pokemon_cards`, `sneakers`).
  TaxonomyCategory? findByType(String type) =>
      _categoriesByType[type.toLowerCase().trim()];

  /// Retrieves an attribute definition by its numeric [id].
  TaxonomyAttribute? getAttribute(int id) => _attributesById[id];

  /// Finds an attribute definition by its [key] slug (e.g. `sneakers.shoe_size`).
  TaxonomyAttribute? findAttributeByKey(String key) =>
      _attributesByKey[key.toLowerCase().trim()];

  /// Returns all top-level root categories (those without a parent).
  List<TaxonomyCategory> getRootCategories() =>
      kTaxonomyCategories.where((c) => c.isRoot).toList();

  /// Returns direct subcategories for a given [parentId].
  List<TaxonomyCategory> getSubcategories(int parentId) =>
      kTaxonomyCategories.where((c) => c.parentId == parentId).toList();

  /// Searches categories matching [query] in either their display label or machine type slug.
  List<TaxonomyCategory> searchCategories(String query) {
    final clean = query.toLowerCase().trim();
    if (clean.isEmpty) return const [];
    return kTaxonomyCategories.where((c) {
      return c.label.toLowerCase().contains(clean) ||
          c.type.toLowerCase().contains(clean);
    }).toList();
  }

  /// Retrieves all attribute definitions and requirement statuses for [categoryId].
  List<CategoryAttributeDetail> getAttributesForCategory(int categoryId) {
    final category = _categoriesById[categoryId];
    if (category == null) return const [];

    final result = <CategoryAttributeDetail>[];
    for (final ref in category.attributes) {
      final attr = _attributesById[ref.id];
      if (attr != null) {
        result.add(CategoryAttributeDetail(attr, ref.isRequired));
      }
    }
    return result;
  }

  /// Validates a map of item [attributes] against the taxonomy rules for [categoryId].
  ///
  /// Returns a list of [AttributeValidationError]s found, or an empty list if valid.
  List<AttributeValidationError> validateAttributes({
    required int categoryId,
    required Map<String, dynamic> attributes,
  }) {
    final category = _categoriesById[categoryId];
    if (category == null) {
      return [
        AttributeValidationError(
          "category_id",
          "Category with ID $categoryId does not exist in the taxonomy.",
        ),
      ];
    }

    final categoryAttrDetails = getAttributesForCategory(categoryId);
    final allowedByKey = {
      for (final detail in categoryAttrDetails)
        detail.attribute.key.toLowerCase(): detail,
    };

    final errors = <AttributeValidationError>[];

    // 1. Check for missing required attributes
    for (final detail in categoryAttrDetails) {
      if (detail.isRequired) {
        final keyLower = detail.attribute.key.toLowerCase();
        final providedKey = attributes.keys.firstWhere(
          (k) => k.toLowerCase() == keyLower,
          orElse: () => "",
        );

        if (providedKey.isEmpty || attributes[providedKey] == null) {
          errors.add(
            AttributeValidationError(
              detail.attribute.key,
              'Missing mandatory attribute: "${detail.attribute.label}" (${detail.attribute.key}).',
              isMissingRequired: true,
            ),
          );
        }
      }
    }

    // 2. Validate each provided attribute
    for (final entry in attributes.entries) {
      final key = entry.key;
      final value = entry.value;
      if (value == null) continue;

      final detail = allowedByKey[key.toLowerCase()];
      if (detail == null) {
        // Unknown or not allowed for this category
        errors.add(
          AttributeValidationError(
            key,
            'Attribute "$key" is not configured for category "${category.label}".',
          ),
        );
        continue;
      }

      final attr = detail.attribute;

      // Type checks
      switch (attr.type.toUpperCase()) {
        case "INTEGER" || "INT":
          if (value is! int) {
            errors.add(
              AttributeValidationError(
                key,
                'Attribute "$key" expects an integer, but got ${value.runtimeType}.',
                isTypeMismatch: true,
              ),
            );
          }
        case "FLOAT" || "DOUBLE" || "NUMBER":
          if (value is! num) {
            errors.add(
              AttributeValidationError(
                key,
                'Attribute "$key" expects a numeric value, but got ${value.runtimeType}.',
                isTypeMismatch: true,
              ),
            );
          }
        case "BOOLEAN" || "BOOL":
          if (value is! bool) {
            errors.add(
              AttributeValidationError(
                key,
                'Attribute "$key" expects a boolean, but got ${value.runtimeType}.',
                isTypeMismatch: true,
              ),
            );
          }
      }

      // Min / Max checks
      if (value is num) {
        if (attr.min != null && value < attr.min!) {
          errors.add(
            AttributeValidationError(
              key,
              'Value $value for "$key" is below minimum allowed (${attr.min}).',
              isInvalidValue: true,
            ),
          );
        }
        if (attr.max != null && value > attr.max!) {
          errors.add(
            AttributeValidationError(
              key,
              'Value $value for "$key" is above maximum allowed (${attr.max}).',
              isInvalidValue: true,
            ),
          );
        }
      }

      // Predefined allowed options check
      if (!attr.allowsCustomValues && attr.values.isNotEmpty) {
        final strVal = value.toString();
        final isValidOption = attr.values.any(
          (opt) => opt.toLowerCase() == strVal.toLowerCase(),
        );

        if (!isValidOption) {
          errors.add(
            AttributeValidationError(
              key,
              'Value "$value" is not an allowed option for "$key". Valid options: ${attr.values.join(', ')}.',
              isInvalidValue: true,
            ),
          );
        }
      }
    }

    return errors;
  }
}
