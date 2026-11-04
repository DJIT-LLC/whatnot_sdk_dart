# whatnot_product_taxonomy

A modern Dart SDK providing Whatnot's official marketplace product categories, hierarchy tree, and category-specific item attributes.

Directly compiled from Whatnot's official [Whatnot-Inc/product-taxonomy](https://github.com/Whatnot-Inc/product-taxonomy) repository using `analyzer_buffer` and built with **Dart 3.13+ Primary Constructors**.

---

## Features

* **350+ Categories**: Complete marketplace hierarchy with machine slugs (`pokemon_cards`, `sneakers`, `funko_pop`) and numeric IDs.
* **440+ Attribute Definitions**: Data types (`STRING`, `INTEGER`, `FLOAT`, `BOOLEAN`), allowed values, min/max bounds, and category associations.
* **Category Search & Tree Navigation**: Find root categories, subcategories, or search categories by keyword.
* **Attribute Validation Engine**: Validate product attributes before making API calls to prevent `422 Unprocessable Entity` errors.
* **Automated Sync Tooling**: Track upstream releases with `dart run tool/update_taxonomy.dart --check`.

---

## Usage

```dart
import 'package:whatnot_product_taxonomy/whatnot_product_taxonomy.dart';

void main() {
  final taxonomy = WhatnotTaxonomy.instance;

  // 1. Look up category
  final category = taxonomy.findByType('pokemon_cards');
  print('Category: ${category?.label} (ID: ${category?.id})'); // Pokémon Cards (ID: 2)

  // 2. Discover attributes
  final attributes = taxonomy.getAttributesForCategory(category!.id);
  for (final detail in attributes) {
    print('- ${detail.attribute.label} (${detail.attribute.key}) Required: ${detail.isRequired}');
  }

  // 3. Validate attributes before submitting to Whatnot Seller API
  final errors = taxonomy.validateAttributes(
    categoryId: category.id,
    attributes: {
      'pokemon.card_condition': 'Near Mint',
    },
  );

  if (errors.isEmpty) {
    print('Attributes are valid!');
  } else {
    for (final error in errors) {
      print('Validation Error: ${error.message}');
    }
  }
}
```

---

## License

MIT

