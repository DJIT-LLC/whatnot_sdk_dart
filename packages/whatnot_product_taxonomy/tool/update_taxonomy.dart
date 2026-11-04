import "dart:convert";
import "dart:io";

import "package:crypto/crypto.dart";
import "package:http/http.dart" as http;

const String _defaultTaxonomyUrl =
    "https://raw.githubusercontent.com/Whatnot-Inc/product-taxonomy/main/data/taxonomy.json";

/// CLI tool to check and update Whatnot product taxonomy from GitHub.
Future<void> main(List<String> args) async {
  final checkOnly = args.contains("--check");
  final update = args.contains("--update");

  final packageDir = File(Platform.script.toFilePath()).parent.parent;
  final localTaxonomyPath = "${packageDir.path}/data/taxonomy.json";
  final versionPath = "${packageDir.path}/data/version.json";

  print("Checking Whatnot product taxonomy at $_defaultTaxonomyUrl...");

  final response = await http.get(Uri.parse(_defaultTaxonomyUrl));
  if (response.statusCode != 200) {
    stderr.writeln(
      "Failed to fetch taxonomy.json. HTTP Status: ${response.statusCode}",
    );
    exit(2);
  }

  final remoteBytes = response.bodyBytes;
  final remoteHash = sha256.convert(remoteBytes).toString().toLowerCase();

  final dynamic remoteJson = jsonDecode(utf8.decode(remoteBytes));
  if (remoteJson is! Map<String, dynamic>) {
    stderr.writeln("Invalid JSON format received from remote taxonomy.");
    exit(2);
  }

  final remoteVersion = remoteJson["version"] as String? ?? "unknown";
  final categories = remoteJson["categories"] as List<dynamic>? ?? [];
  final attributes = remoteJson["attributes"] as List<dynamic>? ?? [];

  // Read local version info if exists
  Map<String, dynamic>? localVersionData;
  final versionFile = File(versionPath);
  if (await versionFile.exists()) {
    try {
      final content = await versionFile.readAsString();
      localVersionData = jsonDecode(content) as Map<String, dynamic>?;
    } catch (_) {}
  }

  final localVersion = localVersionData?["version"] as String? ?? "none";
  final localHash = (localVersionData?["sha256"] as String? ?? "")
      .toLowerCase();

  final hasChanges = remoteHash != localHash || remoteVersion != localVersion;

  if (!hasChanges) {
    print(
      "Whatnot product taxonomy is up-to-date (Version: $localVersion, SHA: ${localHash.substring(0, 8)}).",
    );
    exit(0);
  }

  print("New taxonomy version detected!");
  print(
    '  Local:  $localVersion (${localHash.isEmpty ? "no hash" : localHash.substring(0, 8)})',
  );
  print(
    "  Remote: $remoteVersion (${remoteHash.substring(0, 8)}, ${categories.length} categories, ${attributes.length} attributes)",
  );

  if (checkOnly) {
    print(
      "Run with --update to download the updated taxonomy and recompile data.",
    );
    exit(1);
  }

  if (update || args.isEmpty) {
    print("Updating $localTaxonomyPath...");
    final localFile = File(localTaxonomyPath);
    await localFile.parent.create(recursive: true);
    await localFile.writeAsBytes(remoteBytes);

    final updatedVersionInfo = {
      "sourceUrl": _defaultTaxonomyUrl,
      "version": remoteVersion,
      "sha256": remoteHash,
      "categoriesCount": categories.length,
      "attributesCount": attributes.length,
      "lastChecked": DateTime.now().toUtc().toIso8601String(),
    };

    await versionFile.writeAsString(
      const JsonEncoder.withIndent("  ").convert(updatedVersionInfo),
    );
    print("Updated $versionPath.");

    // Run code generator
    print("Running data compiler (tool/generate_data.dart)...");
    final genResult = await Process.run(
      "puro",
      ["dart", "run", "${packageDir.path}/tool/generate_data.dart"],
      runInShell: true,
      workingDirectory: packageDir.path,
    );

    stdout.write(genResult.stdout);
    stderr.write(genResult.stderr);

    if (genResult.exitCode != 0) {
      stderr.writeln(
        "Data compilation failed with exit code ${genResult.exitCode}.",
      );
      exit(genResult.exitCode);
    }

    print("Taxonomy updated and recompiled successfully!");
    exit(0);
  }
}
