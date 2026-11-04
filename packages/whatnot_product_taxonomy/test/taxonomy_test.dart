import "package:test/test.dart";
import "package:whatnot_product_taxonomy/whatnot_product_taxonomy.dart";

void main() {
  final taxonomy = WhatnotTaxonomy.instance;

  group("WhatnotTaxonomy Core", () {
    test("loads compiled taxonomy dataset with version 1.2.0", () {
      expect(taxonomy.version, equals("1.2.0"));
      expect(taxonomy.allCategories.length, equals(350));
      expect(taxonomy.allAttributes.length, equals(444));
    });

    test("looks up categories by ID and slug", () {
      final pokemon = taxonomy.getCategory(2);
      expect(pokemon, isNotNull);
      expect(pokemon!.type, equals("pokemon_cards"));
      expect(pokemon.label, equals("Pokémon Cards"));
      expect(pokemon.allowsInventory, isTrue);

      final bySlug = taxonomy.findByType("pokemon_cards");
      expect(bySlug?.id, equals(2));

      final funko = taxonomy.getCategory(1);
      expect(funko?.label, equals("Funko"));
    });

    test("navigates category tree hierarchy", () {
      final roots = taxonomy.getRootCategories();
      expect(roots, isNotEmpty);
      expect(roots.every((c) => c.isRoot), isTrue);

      // Funko (id: 1) has subcategory Funko Soda (id: 4)
      final funkoSubs = taxonomy.getSubcategories(1);
      expect(funkoSubs.any((c) => c.id == 4), isTrue);
    });

    test("searches categories by keyword", () {
      final results = taxonomy.searchCategories("pokemon");
      expect(results, isNotEmpty);
      expect(results.first.type, equals("pokemon_cards"));

      final sneakerResults = taxonomy.searchCategories("sneakers");
      expect(sneakerResults.any((c) => c.type == "sneakers"), isTrue);
    });
  });

  group("Taxonomy Attributes", () {
    test("looks up attribute by key slug", () {
      final shoeSize = taxonomy.findAttributeByKey("sneakers.shoe_size");
      expect(shoeSize, isNotNull);
      expect(shoeSize!.label, equals("Size"));
      expect(shoeSize.type, equals("STRING"));
      expect(shoeSize.allowsCustomValues, isTrue);
      expect(shoeSize.values, contains("10M"));
    });

    test("retrieves category-specific attributes", () {
      final pokemonAttrs = taxonomy.getAttributesForCategory(2);
      expect(pokemonAttrs, isNotEmpty);
      expect(pokemonAttrs.every((detail) => detail.attribute.id > 0), isTrue);
    });
  });

  group("Attribute Validation", () {
    test("fails validation when category does not exist", () {
      final errors = taxonomy.validateAttributes(
        categoryId: 9999999,
        attributes: {"some_attr": "val"},
      );
      expect(errors.length, equals(1));
      expect(errors.first.message, contains("does not exist"));
    });

    test("fails validation when attribute is not configured for category", () {
      // Sneakers ID is 49. It does not have pokemon card attributes.
      final errors = taxonomy.validateAttributes(
        categoryId: 49,
        attributes: {"pokemon.card_condition": "Near Mint"},
      );
      expect(errors, isNotEmpty);
      expect(errors.first.message, contains("not configured for category"));
    });

    test("validates enum values when custom values are not allowed", () {
      // Find an attribute that does not allow custom values
      final strictAttr = taxonomy.allAttributes.firstWhere(
        (a) => !a.allowsCustomValues && a.values.isNotEmpty,
      );

      // Find a category that uses this attribute
      final categoryWithStrictAttr = taxonomy.allCategories.firstWhere(
        (c) => c.attributes.any((ref) => ref.id == strictAttr.id),
      );

      // Valid option
      final validErrors = taxonomy.validateAttributes(
        categoryId: categoryWithStrictAttr.id,
        attributes: {strictAttr.key: strictAttr.values.first},
      );
      expect(
        validErrors.where((e) => e.attributeKey == strictAttr.key),
        isEmpty,
      );

      // Invalid option
      final invalidErrors = taxonomy.validateAttributes(
        categoryId: categoryWithStrictAttr.id,
        attributes: {strictAttr.key: "TOTALLY_INVALID_OPTION_XYZ"},
      );
      expect(invalidErrors.any((e) => e.isInvalidValue), isTrue);
    });

    test("detects data type mismatch", () {
      // Find an integer attribute
      final intAttr = taxonomy.allAttributes.firstWhere(
        (a) =>
            a.type.toUpperCase() == "INT" || a.type.toUpperCase() == "INTEGER",
      );

      final category = taxonomy.allCategories.firstWhere(
        (c) => c.attributes.any((ref) => ref.id == intAttr.id),
      );

      final errors = taxonomy.validateAttributes(
        categoryId: category.id,
        attributes: {
          intAttr.key: "not_an_int", // should be int
        },
      );

      expect(errors.any((e) => e.isTypeMismatch), isTrue);
    });
  });
}
