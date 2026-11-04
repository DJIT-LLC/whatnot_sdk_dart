import "dart:convert";
import "dart:io";

import "package:crypto/crypto.dart";
import "package:http/http.dart" as http;

const String _defaultSpecUrl =
    "https://developers.whatnot.com/api-reference/openapi.json";

/// CLI tool to check and update the Whatnot Seller API OpenAPI specification.
Future<void> main(List<String> args) async {
  final checkOnly = args.contains("--check");
  final update = args.contains("--update");

  final packageDir = File(Platform.script.toFilePath()).parent.parent;
  final localSpecPath = "${packageDir.path}/schemes/openapi.json";
  final versionPath = "${packageDir.path}/schemes/version.json";

  print("Checking Whatnot OpenAPI specification at $_defaultSpecUrl...");

  final response = await http.get(Uri.parse(_defaultSpecUrl));
  if (response.statusCode != 200) {
    stderr.writeln(
      "Failed to fetch OpenAPI spec. HTTP Status: ${response.statusCode}",
    );
    exit(2);
  }

  final remoteBytes = response.bodyBytes;
  final remoteHash = sha256.convert(remoteBytes).toString().toLowerCase();

  final dynamic remoteJson = jsonDecode(utf8.decode(remoteBytes));
  if (remoteJson is! Map<String, dynamic>) {
    stderr.writeln("Invalid JSON format received from remote spec.");
    exit(2);
  }

  final remoteInfo = remoteJson["info"] as Map<String, dynamic>? ?? {};
  final remoteVersion = remoteInfo["version"] as String? ?? "unknown";
  final remoteTitle = remoteInfo["title"] as String? ?? "Whatnot Seller API";

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
      "OpenAPI specification is up-to-date (Version: $localVersion, SHA: ${localHash.substring(0, 8)}).",
    );
    exit(0);
  }

  print("New OpenAPI specification detected!");
  print(
    '  Local version:  $localVersion (${localHash.isEmpty ? "no hash" : localHash.substring(0, 8)})',
  );
  print("  Remote version: $remoteVersion (${remoteHash.substring(0, 8)})");

  if (checkOnly) {
    print(
      "Run with --update to download the updated specification and regenerate code.",
    );
    exit(1);
  }

  if (update || args.isEmpty) {
    print("Updating $localSpecPath...");
    final localSpecFile = File(localSpecPath);
    await localSpecFile.parent.create(recursive: true);
    await localSpecFile.writeAsBytes(remoteBytes);

    final updatedVersionInfo = {
      "specUrl": _defaultSpecUrl,
      "version": remoteVersion,
      "title": remoteTitle,
      "sha256": remoteHash,
      "lastChecked": DateTime.now().toUtc().toIso8601String(),
    };

    await versionFile.writeAsString(
      const JsonEncoder.withIndent("  ").convert(updatedVersionInfo),
    );
    print("Updated $versionPath.");

    // Run code generator
    print("Running code generator (tool/generate.dart)...");
    final genResult = await Process.run(
      "puro",
      ["dart", "run", "${packageDir.path}/tool/generate.dart"],
      runInShell: true,
      workingDirectory: packageDir.path,
    );

    stdout.write(genResult.stdout);
    stderr.write(genResult.stderr);

    if (genResult.exitCode != 0) {
      stderr.writeln(
        "Code generation failed with exit code ${genResult.exitCode}.",
      );
      exit(genResult.exitCode);
    }

    print("OpenAPI spec updated and SDK code regenerated successfully!");
    exit(0);
  }
}
