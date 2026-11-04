import "dart:convert";
import "dart:io";

import "package:analyzer_buffer/analyzer_buffer.dart";

void main() async {
  final packageDir = File(Platform.script.toFilePath()).parent.parent;
  final taxonomyFile = File("${packageDir.path}/data/taxonomy.json");
  if (!taxonomyFile.existsSync()) {
    stderr.writeln("data/taxonomy.json not found at ${taxonomyFile.path}!");
    exit(1);
  }

  print("Parsing data/taxonomy.json...");
  final dynamic json = jsonDecode(taxonomyFile.readAsStringSync());
  if (json is! Map<String, dynamic>) {
    stderr.writeln("Invalid taxonomy JSON structure.");
    exit(1);
  }

  final version = json["version"] as String? ?? "1.0.0";
  final rawCategories = json["categories"] as List<dynamic>? ?? [];
  final rawAttributes = json["attributes"] as List<dynamic>? ?? [];

  print(
    "Compiling $version (${rawCategories.length} categories, ${rawAttributes.length} attributes)...",
  );

  final outputDir = Directory("${packageDir.path}/lib/src/generated");
  if (!outputDir.existsSync()) outputDir.createSync(recursive: true);

  final buffer = AnalyzerBuffer.newLibrary(
    packageName: "whatnot_product_taxonomy",
    path: "lib/src/generated/taxonomy_data.dart",
    header: "// GENERATED FILE - DO NOT EDIT MANUALLY\n// ignore_for_file: unused_import, no_leading_underscores_for_library_prefixes",
  );

  buffer.write("""
/// The compiled semantic version of Whatnot Product Taxonomy.
const String kTaxonomyVersion = '$version';

/// Compiled list of all categories in Whatnot's marketplace taxonomy.
final List<#{{whatnot_product_taxonomy/src/models/taxonomy_category.dart|TaxonomyCategory}}> kTaxonomyCategories = [
""");

  for (final c in rawCategories) {
    if (c is! Map<String, dynamic>) continue;
    final id = (c["id"] as num).toInt();
    final type = _escapeString((c["type"] ?? "").toString());
    final label = _escapeString((c["label"] ?? "").toString());
    final parentId = c["parent_id"] != null
        ? (c["parent_id"] as num).toInt()
        : null;
    final allowsInventory = c["allows_inventory"] == true;

    final attrs = (c["attributes"] as List<dynamic>?) ?? [];

    buffer.write(
      "  #{{whatnot_product_taxonomy/src/models/taxonomy_category.dart|TaxonomyCategory}}(\n",
    );
    buffer.write("    $id,\n");
    buffer.write("    '$type',\n");
    buffer.write("    '$label',\n");
    buffer.write("    $parentId,\n");
    buffer.write("    $allowsInventory,\n");
    buffer.write("    [\n");
    for (final a in attrs) {
      if (a is! Map<String, dynamic>) continue;
      final aId = (a["id"] as num).toInt();
      final isReq = a["is_required"] == true;
      buffer.write(
        "      #{{whatnot_product_taxonomy/src/models/category_attribute_ref.dart|CategoryAttributeRef}}($aId, $isReq),\n",
      );
    }
    buffer.write("    ],\n");
    buffer.write("  ),\n");
  }

  buffer.write("];\n\n");

  buffer.write("""
/// Compiled list of all attribute definitions in Whatnot's marketplace taxonomy.
final List<#{{whatnot_product_taxonomy/src/models/taxonomy_attribute.dart|TaxonomyAttribute}}> kTaxonomyAttributes = [
""");

  for (final a in rawAttributes) {
    if (a is! Map<String, dynamic>) continue;
    final id = (a["id"] as num).toInt();
    final key = _escapeString((a["key"] ?? "").toString());
    final label = _escapeString((a["label"] ?? "").toString());
    final type = _escapeString((a["type"] ?? "STRING").toString());
    final allowsCustom = a["allows_custom_values"] == true;
    final values =
        (a["values"] as List<dynamic>?)
            ?.map((e) => _escapeString(e.toString()))
            .toList() ??
        [];
    final min = a["min"] as num?;
    final max = a["max"] as num?;

    buffer.write(
      "  #{{whatnot_product_taxonomy/src/models/taxonomy_attribute.dart|TaxonomyAttribute}}(\n",
    );
    buffer.write("    $id,\n");
    buffer.write("    '$key',\n");
    buffer.write("    '$label',\n");
    buffer.write("    '$type',\n");
    buffer.write("    $allowsCustom,\n");
    buffer.write("    [\n");
    for (final v in values) {
      buffer.write("      '$v',\n");
    }
    buffer.write("    ],\n");
    buffer.write("    $min,\n");
    buffer.write("    $max,\n");
    buffer.write("  ),\n");
  }

  buffer.write("];\n");

  final outputFile = File(
    "${packageDir.path}/lib/src/generated/taxonomy_data.dart",
  );
  outputFile.writeAsStringSync(buffer.toString());

  print("Formatting generated data using puro dart format...");
  await Process.run("puro", [
    "dart",
    "format",
    "${packageDir.path}/lib/src/generated",
  ], runInShell: true);

  print("Taxonomy compilation finished successfully!");
}

String _escapeString(String str) {
  return str
      .replaceAll(r"\", r"\\")
      .replaceAll("'", r"\'")
      .replaceAll(r"$", r"\$")
      .replaceAll("\n", r"\n")
      .replaceAll("\r", r"\r");
}
