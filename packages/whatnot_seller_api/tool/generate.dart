import "dart:convert";
import "dart:io";

import "package:analyzer_buffer/analyzer_buffer.dart";

const Set<String> _dartKeywords = {
  "assert",
  "break",
  "case",
  "catch",
  "class",
  "const",
  "continue",
  "default",
  "do",
  "else",
  "enum",
  "extends",
  "false",
  "final",
  "finally",
  "for",
  "if",
  "in",
  "is",
  "new",
  "null",
  "rethrow",
  "return",
  "super",
  "switch",
  "this",
  "throw",
  "true",
  "try",
  "var",
  "void",
  "while",
  "with",
};

String _sanitizeIdentifier(String name) {
  var clean = name.replaceAll(RegExp(r"[^a-zA-Z0-9_]"), "_");
  if (clean.isEmpty) clean = "value";
  if (_dartKeywords.contains(clean)) {
    return "${clean}_";
  }
  if (RegExp(r"^[0-9]").hasMatch(clean)) {
    return "n$clean";
  }
  return clean;
}

String _toCamelCase(String text) {
  final parts = text
      .split(RegExp(r"[_-\s]+"))
      .where((p) => p.isNotEmpty)
      .toList();
  if (parts.isEmpty) return "val";
  final first = parts.first.toLowerCase();
  final rest = parts
      .skip(1)
      .map(
        (p) =>
            p.isEmpty ? "" : p[0].toUpperCase() + p.substring(1).toLowerCase(),
      );
  final result = "$first${rest.join()}";
  return _sanitizeIdentifier(result);
}

String _toPascalCase(String text) {
  final parts = text
      .split(RegExp(r"[_-\s]+"))
      .where((p) => p.isNotEmpty)
      .toList();
  if (parts.isEmpty) return "Val";
  return parts.map((p) {
    if (p.isEmpty) return "";
    return p[0].toUpperCase() + p.substring(1);
  }).join();
}

String _toSnakeCase(String name) {
  return name
      .replaceAllMapped(
        RegExp(r"([A-Z]+)([A-Z][a-z])"),
        (Match m) => "${m[1]}_${m[2]}",
      )
      .replaceAllMapped(
        RegExp(r"([a-z\d])([A-Z])"),
        (Match m) => "${m[1]}_${m[2]}",
      )
      .toLowerCase()
      .replaceAll(RegExp(r"[^a-z0-9_]"), "_");
}

void main() async {
  final packageDir = File(Platform.script.toFilePath()).parent.parent;
  final specFile = File("${packageDir.path}/schemes/openapi.json");
  if (!specFile.existsSync()) {
    stderr.writeln("schemes/openapi.json not found at ${specFile.path}!");
    exit(1);
  }

  print("Parsing schemes/openapi.json...");
  final dynamic json = jsonDecode(specFile.readAsStringSync());
  if (json is! Map<String, dynamic>) {
    stderr.writeln("Invalid OpenAPI JSON structure.");
    exit(1);
  }

  final components = json["components"] as Map<String, dynamic>? ?? {};
  final schemas = components["schemas"] as Map<String, dynamic>? ?? {};
  final paths = json["paths"] as Map<String, dynamic>? ?? {};

  final modelsDir = Directory("${packageDir.path}/lib/src/generated/models");
  final apiDir = Directory("${packageDir.path}/lib/src/generated/api");

  if (modelsDir.existsSync()) modelsDir.deleteSync(recursive: true);
  if (apiDir.existsSync()) apiDir.deleteSync(recursive: true);

  modelsDir.createSync(recursive: true);
  apiDir.createSync(recursive: true);

  final generatedModels = <String>[];
  final enumNames = <String>{};

  // Identify all enums first
  schemas.forEach((name, schemaData) {
    if (schemaData is Map<String, dynamic> && schemaData["enum"] != null) {
      enumNames.add(name);
    }
  });

  // Generate Models with AnalyzerBuffer
  print("Generating ${schemas.length} models using AnalyzerBuffer...");
  schemas.forEach((schemaName, schemaData) {
    if (schemaData is! Map<String, dynamic>) return;

    final fileName = "${_toSnakeCase(schemaName)}.dart";
    final code = _generateSchemaCode(
      schemaName,
      schemaData,
      enumNames,
      fileName,
    );
    File("${modelsDir.path}/$fileName").writeAsStringSync(code);
    generatedModels.add(fileName);
  });

  // Generate Model Barrel
  final modelsBarrel = StringBuffer();
  modelsBarrel.writeln("// Generated barrel for OpenAPI models.\n");
  for (final m in generatedModels..sort()) {
    modelsBarrel.writeln("export 'models/$m';");
  }
  File("${packageDir.path}/lib/src/generated/models.dart")
      .writeAsStringSync(modelsBarrel.toString());

  // Group Paths by Tag
  final tagOperations = <String, List<_Operation>>{};
  paths.forEach((pathUri, pathItem) {
    if (pathItem is! Map<String, dynamic>) return;
    pathItem.forEach((method, opData) {
      if (opData is! Map<String, dynamic>) return;
      if (![
        "get",
        "post",
        "patch",
        "delete",
        "put",
      ].contains(method.toLowerCase())) {
        return;
      }

      final tags =
          (opData["tags"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [];
      final tag = tags.isEmpty ? "General" : tags.first;

      tagOperations
          .putIfAbsent(tag, () => [])
          .add(
            _Operation(
              path: pathUri,
              method: method.toUpperCase(),
              data: opData,
            ),
          );
    });
  });

  // Generate API Resource Classes with AnalyzerBuffer
  print(
    "Generating ${tagOperations.length} API Resource classes using AnalyzerBuffer...",
  );
  final generatedApis = <String>[];
  tagOperations.forEach((tag, ops) {
    final apiClassName = '${_toPascalCase(tag.replaceAll('&', 'And'))}Api';
    final fileName = "${_toSnakeCase(apiClassName)}.dart";
    final code = _generateApiCode(apiClassName, ops, enumNames, fileName);
    File("${apiDir.path}/$fileName").writeAsStringSync(code);
    generatedApis.add(fileName);
  });

  // Generate API Barrel
  final apiBarrel = StringBuffer();
  apiBarrel.writeln("// Generated barrel for OpenAPI REST APIs.\n");
  for (final a in generatedApis..sort()) {
    apiBarrel.writeln("export 'api/$a';");
  }
  File("${packageDir.path}/lib/src/generated/api.dart")
      .writeAsStringSync(apiBarrel.toString());

  print("Formatting generated code using puro dart format...");
  final formatResult = await Process.run("puro", [
    "dart",
    "format",
    "${packageDir.path}/lib/src/generated",
  ], runInShell: true);
  if (formatResult.exitCode != 0) {
    stderr.writeln(formatResult.stderr);
  }

  print("Code generation completed successfully using AnalyzerBuffer!");
}

String _generateSchemaCode(
  String schemaName,
  Map<String, dynamic> schema,
  Set<String> enumNames,
  String fileName,
) {
  final className = _toPascalCase(schemaName);
  final buffer = AnalyzerBuffer.newLibrary(
    packageName: "whatnot_seller_api",
    path: "lib/src/generated/models/$fileName",
    header:
        "// Generated model: $className\n// ignore_for_file: unused_import, unnecessary_question_mark, no_leading_underscores_for_library_prefixes",
  );

  final description = schema["description"] as String?;
  if (description != null && description.isNotEmpty) {
    buffer.write("/// ${_cleanDoc(description)}\n");
  }

  // Check if Enum
  if (schema["enum"] != null) {
    final rawEnums = schema["enum"] as List<dynamic>;
    buffer.write("enum $className {\n");
    for (var i = 0; i < rawEnums.length; i++) {
      final val = rawEnums[i].toString();
      final identifier = _toCamelCase(val);
      final comma = i == rawEnums.length - 1 ? ";" : ",";
      buffer.write("  $identifier('$val')$comma\n");
    }
    buffer.write("\n  final String value;\n");
    buffer.write("  const $className(this.value);\n\n");
    buffer.write("  factory $className.fromJson(dynamic json) {\n");
    buffer.write("    return $className.values.firstWhere(\n");
    buffer.write(
      "      (e) => e.value.toLowerCase() == json.toString().toLowerCase(),\n",
    );
    buffer.write(
      "      orElse: () => $className.${_toCamelCase(rawEnums.first.toString())},\n",
    );
    buffer.write("    );\n");
    buffer.write("  }\n\n");
    buffer.write("  String toJson() => value;\n");
    buffer.write("}\n");
    return buffer.toString();
  }

  // Object / Data Class using Primary Constructor!
  final properties = schema["properties"] as Map<String, dynamic>? ?? {};
  final requiredFields =
      (schema["required"] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toSet() ??
      <String>{};

  final fields = <_Field>[];
  properties.forEach((propName, propData) {
    if (propData is! Map<String, dynamic>) return;
    fields.add(
      _Field.fromSchema(
        propName,
        propData,
        isRequired: requiredFields.contains(propName),
        enumNames: enumNames,
      ),
    );
  });

  if (fields.isEmpty) {
    buffer.write("class $className {\n");
    buffer.write("  const $className();\n\n");
    buffer.write(
      "  factory $className.fromJson(Map<String, dynamic> json) => const $className();\n\n",
    );
    buffer.write("  Map<String, dynamic> toJson() => const {};\n");
    buffer.write("}\n");
    return buffer.toString();
  }

  // Primary Constructor Header!
  buffer.write("class $className(\n");
  for (final f in fields) {
    if (f.description != null && f.description!.isNotEmpty) {
      buffer.write("  /// ${_cleanDoc(f.description!)}\n");
    }
    buffer.write("  final ${f.dartType} ${f.fieldName},\n");
  }
  buffer.write(") {\n");

  // fromJson Factory
  buffer.write(
    "  factory $className.fromJson(Map<String, dynamic> json) => $className(\n",
  );
  for (final f in fields) {
    buffer.write("    ${f.fromJsonExpr},\n");
  }
  buffer.write("  );\n\n");

  // toJson Method
  buffer.write("  Map<String, dynamic> toJson() => {\n");
  for (final f in fields) {
    if (f.isNullable) {
      buffer.write(
        "    if (${f.fieldName} != null) '${f.jsonKey}': ${f.toJsonExpr},\n",
      );
    } else {
      buffer.write("    '${f.jsonKey}': ${f.toJsonExpr},\n");
    }
  }
  buffer.write("  };\n");
  buffer.write("}\n");

  return buffer.toString();
}

String _generateApiCode(
  String apiClassName,
  List<_Operation> ops,
  Set<String> enumNames,
  String fileName,
) {
  final buffer = AnalyzerBuffer.newLibrary(
    packageName: "whatnot_seller_api",
    path: "lib/src/generated/api/$fileName",
    header:
        "// Generated API class: $apiClassName\n// ignore_for_file: unused_import, no_leading_underscores_for_library_prefixes",
  );

  buffer.write("/// Resource client for $apiClassName operations.\n");
  buffer.write(
    "class $apiClassName(final #{{whatnot_seller_api/src/http/whatnot_http_client.dart|WhatnotHttpClient}} _client) {\n",
  );

  for (final op in ops) {
    final method = op.method;
    final path = op.path;
    final opData = op.data;
    final summary =
        opData["summary"] as String? ?? opData["description"] as String?;
    final operationId = opData["operationId"] as String? ?? "";

    final methodName = _cleanMethodName(operationId, method, path);

    // Collect Parameters
    final pathParams = <_Param>[];
    final queryParams = <_Param>[];

    final parameters = (opData["parameters"] as List<dynamic>?) ?? [];
    for (final p in parameters) {
      if (p is! Map<String, dynamic>) continue;
      final inWhere = p["in"] as String? ?? "";
      final pName = p["name"] as String? ?? "";
      final isRequired = p["required"] == true;
      final pSchema = p["schema"] as Map<String, dynamic>? ?? {};
      final dartType = _resolveType(pSchema, enumNames, forApi: true);

      if (inWhere == "path") {
        pathParams.add(_Param(pName, _toCamelCase(pName), dartType, true));
      } else if (inWhere == "query") {
        final nullableType = dartType.endsWith("?") ? dartType : "$dartType?";
        queryParams.add(
          _Param(
            pName,
            _toCamelCase(pName),
            isRequired ? dartType : nullableType,
            isRequired,
          ),
        );
      }
    }

    // Request Body
    _Param? bodyParam;
    final reqBody = opData["requestBody"] as Map<String, dynamic>?;
    if (reqBody != null) {
      final content = reqBody["content"] as Map<String, dynamic>? ?? {};
      final appJson = content["application/json"] as Map<String, dynamic>?;
      if (appJson != null) {
        final bodySchema = appJson["schema"] as Map<String, dynamic>? ?? {};
        final bodyType = _resolveType(bodySchema, enumNames, forApi: true);
        bodyParam = _Param("body", "request", bodyType, true);
      }
    }

    // Determine Response Type
    var returnType = "dynamic";
    final responses = opData["responses"] as Map<String, dynamic>? ?? {};
    final successResp = responses["200"] ?? responses["201"];
    if (successResp is Map<String, dynamic>) {
      final content = successResp["content"] as Map<String, dynamic>? ?? {};
      final appJson = content["application/json"] as Map<String, dynamic>?;
      if (appJson != null) {
        final respSchema = appJson["schema"] as Map<String, dynamic>? ?? {};
        returnType = _resolveType(respSchema, enumNames, forApi: true);
      } else {
        returnType = "void";
      }
    } else if (responses["204"] != null) {
      returnType = "void";
    }

    if (summary != null && summary.isNotEmpty) {
      buffer.write("\n  /// ${_cleanDoc(summary)}\n");
    }

    // Method Signature
    final positionalArgs = <String>[];
    final namedArgs = <String>[];

    for (final p in pathParams) {
      positionalArgs.add("${p.dartType} ${p.dartName}");
    }

    if (bodyParam != null) {
      positionalArgs.add("${bodyParam.dartType} ${bodyParam.dartName}");
    }

    for (final q in queryParams) {
      namedArgs.add(
        '${q.isRequired ? "required " : ""}${q.dartType} ${q.dartName}',
      );
    }

    final paramSignature = [
      ...positionalArgs,
      if (namedArgs.isNotEmpty) '{${namedArgs.join(', ')}}',
    ].join(", ");

    buffer.write(
      "  Future<$returnType> $methodName($paramSignature) async {\n",
    );

    // Build URL string with path params
    var urlExpr = "'$path'";
    for (final p in pathParams) {
      urlExpr = urlExpr.replaceAll("{${p.rawName}}", "\$${p.dartName}");
    }

    // Build queryParams map if any
    if (queryParams.isNotEmpty) {
      buffer.write("    final queryParameters = <String, dynamic>{\n");
      for (final q in queryParams) {
        buffer.write(
          "      if (${q.dartName} != null) '${q.rawName}': ${q.dartName},\n",
        );
      }
      buffer.write("    };\n");
    }

    final queryArg = queryParams.isNotEmpty
        ? ", queryParameters: queryParameters"
        : "";
    final bodyArg = bodyParam != null
        ? ", body: ${bodyParam.dartName}.toJson()"
        : "";

    final clientCall =
        "_client.${method.toLowerCase()}($urlExpr$bodyArg$queryArg)";

    if (returnType == "void") {
      buffer.write("    await $clientCall;\n");
    } else if (returnType.startsWith("List<") && returnType.endsWith(">")) {
      final innerType = returnType.substring(5, returnType.length - 1);
      buffer.write("    final response = await $clientCall;\n");
      buffer.write("    if (response is! List) return <$innerType>[];\n");
      if (innerType == "String" ||
          innerType == "int" ||
          innerType == "double" ||
          innerType == "bool") {
        buffer.write("    return response.cast<$innerType>();\n");
      } else {
        buffer.write(
          "    return response.map((item) => $innerType.fromJson(item as Map<String, dynamic>)).toList();\n",
        );
      }
    } else if (returnType != "dynamic" && !returnType.startsWith("Map")) {
      buffer.write("    final response = await $clientCall;\n");
      buffer.write(
        "    return $returnType.fromJson(response as Map<String, dynamic>);\n",
      );
    } else {
      buffer.write("    return await $clientCall;\n");
    }

    buffer.write("  }\n");
  }

  buffer.write("}\n");
  return buffer.toString();
}

String _cleanDoc(String doc) {
  return doc
      .replaceAll("\n", " ")
      .replaceAll("\r", "")
      .replaceAll("///", "")
      .trim();
}

String _cleanMethodName(String operationId, String method, String path) {
  if (operationId.isNotEmpty) {
    var raw = operationId;
    if (raw.startsWith("seller_api_v2_")) {
      raw = raw.substring("seller_api_v2_".length);
    }

    final pathSegments = path
        .split("/")
        .where((s) => s.isNotEmpty && !s.startsWith("{"))
        .toList();
    if (pathSegments.isNotEmpty) {
      final firstSeg = pathSegments.first.toLowerCase();
      final idx = raw.indexOf("_$firstSeg");
      if (idx != -1) {
        var fnName = raw.substring(0, idx);
        if (fnName.endsWith("_endpoint")) {
          fnName = fnName.substring(0, fnName.length - "_endpoint".length);
        }
        final camel = _toCamelCase(fnName);
        if (camel.length >= 3) return camel;
      }
    }

    if (raw.contains("__")) {
      raw = raw.split("__").first;
    }
    raw = raw.replaceAll(RegExp(r"_(get|post|patch|delete|put)$"), "");

    final result = _toCamelCase(raw);
    if (result.length >= 3) return result;
  }

  // Fallback to method + path
  final segments = path
      .split("/")
      .where((s) => s.isNotEmpty && !s.startsWith("{"))
      .toList();
  final lastSegment = segments.isEmpty ? "root" : segments.last;
  return _toCamelCase("${method.toLowerCase()}_$lastSegment");
}

String _resolveType(
  Map<String, dynamic> schema,
  Set<String> enumNames, {
  bool forApi = false,
}) {
  if (schema.containsKey(r"$ref")) {
    final ref = schema[r"$ref"] as String;
    final schemaName = ref.split("/").last;
    final typeName = _toPascalCase(schemaName);
    final fileName = "${_toSnakeCase(schemaName)}.dart";
    if (forApi) {
      return "#{{whatnot_seller_api/src/generated/models.dart|$typeName}}";
    } else {
      return "#{{whatnot_seller_api/src/generated/models/$fileName|$typeName}}";
    }
  }

  if (schema.containsKey("anyOf")) {
    final anyOf = schema["anyOf"] as List<dynamic>;
    final nonNull = anyOf
        .where((item) => item is Map && item["type"] != "null")
        .toList();
    if (nonNull.length == 1 && nonNull.first is Map<String, dynamic>) {
      final inner = _resolveType(
        nonNull.first as Map<String, dynamic>,
        enumNames,
        forApi: forApi,
      );
      return inner.endsWith("?") ? inner : "$inner?";
    } else if (nonNull.length > 1) {
      return "dynamic";
    }
  }

  if (schema.containsKey("oneOf")) {
    return "dynamic";
  }

  final type = schema["type"] as String?;
  final format = schema["format"] as String?;

  switch (type) {
    case "string":
      if (format == "date-time") return "DateTime";
      return "String";
    case "integer":
      return "int";
    case "number":
      return "double";
    case "boolean":
      return "bool";
    case "array":
      final items = schema["items"] as Map<String, dynamic>? ?? {};
      final itemType = _resolveType(items, enumNames, forApi: forApi);
      return "List<$itemType>";
    case "object":
      return "Map<String, dynamic>";
    default:
      return "dynamic";
  }
}

class _Field {
  final String jsonKey;
  final String fieldName;
  final String dartType;
  final String fromJsonExpr;
  final String toJsonExpr;
  final bool isNullable;
  final String? description;

  _Field({
    required this.jsonKey,
    required this.fieldName,
    required this.dartType,
    required this.fromJsonExpr,
    required this.toJsonExpr,
    required this.isNullable,
    this.description,
  });

  factory _Field.fromSchema(
    String propName,
    Map<String, dynamic> schema, {
    required bool isRequired,
    required Set<String> enumNames,
  }) {
    final fieldName = _toCamelCase(propName);
    var baseType = _resolveType(schema, enumNames);
    var isNullable = !isRequired || schema["nullable"] == true;

    if (schema["anyOf"] != null) {
      final anyOf = schema["anyOf"] as List<dynamic>;
      if (anyOf.any((element) => element is Map && element["type"] == "null")) {
        isNullable = true;
      }
    }

    if (baseType.endsWith("?")) {
      isNullable = true;
      baseType = baseType.substring(0, baseType.length - 1);
    }

    final dartType = isNullable ? "$baseType?" : baseType;

    // fromJson & toJson expressions
    String fromJsonExpr;
    String toJsonExpr;

    if (baseType == "DateTime") {
      fromJsonExpr = isNullable
          ? "json['$propName'] != null ? DateTime.parse(json['$propName'] as String) : null"
          : "DateTime.parse(json['$propName'] as String)";
      toJsonExpr = "$fieldName${isNullable ? '?' : ''}.toIso8601String()";
    } else if (baseType.startsWith("List<")) {
      final innerType = baseType.substring(5, baseType.length - 1);
      final cleanInner = innerType.replaceAll("?", "");
      if (cleanInner == "String" ||
          cleanInner == "int" ||
          cleanInner == "double" ||
          cleanInner == "bool" ||
          cleanInner == "dynamic") {
        fromJsonExpr = isNullable
            ? "(json['$propName'] as List<dynamic>?)?.map((e) => e as $innerType).toList()"
            : "(json['$propName'] as List<dynamic>).map((e) => e as $innerType).toList()";
        toJsonExpr = fieldName;
      } else {
        fromJsonExpr = isNullable
            ? "(json['$propName'] as List<dynamic>?)?.map((e) => $innerType.fromJson(e as Map<String, dynamic>)).toList()"
            : "(json['$propName'] as List<dynamic>).map((e) => $innerType.fromJson(e as Map<String, dynamic>)).toList()";
        toJsonExpr =
            "$fieldName${isNullable ? '?' : ''}.map((e) => e.toJson()).toList()";
      }
    } else if (baseType.startsWith("#{{")) {
      // Check if enum: extract schema name from #{{.../$fileName|$typeName}}
      final typeName = baseType.split("|").last.replaceAll("}}", "");
      if (enumNames.contains(typeName)) {
        fromJsonExpr = isNullable
            ? "json['$propName'] != null ? $baseType.fromJson(json['$propName']) : null"
            : "$baseType.fromJson(json['$propName'])";
        toJsonExpr = "$fieldName${isNullable ? '?' : ''}.toJson()";
      } else {
        fromJsonExpr = isNullable
            ? "json['$propName'] != null ? $baseType.fromJson(json['$propName'] as Map<String, dynamic>) : null"
            : "$baseType.fromJson(json['$propName'] as Map<String, dynamic>)";
        toJsonExpr = "$fieldName${isNullable ? '?' : ''}.toJson()";
      }
    } else if (baseType == "int" ||
        baseType == "double" ||
        baseType == "String" ||
        baseType == "bool") {
      fromJsonExpr = "json['$propName'] as $dartType";
      toJsonExpr = fieldName;
    } else if (baseType == "Map<String, dynamic>" || baseType == "dynamic") {
      fromJsonExpr = "json['$propName'] as $dartType";
      toJsonExpr = fieldName;
    } else {
      fromJsonExpr = isNullable
          ? "json['$propName'] != null ? $baseType.fromJson(json['$propName'] as Map<String, dynamic>) : null"
          : "$baseType.fromJson(json['$propName'] as Map<String, dynamic>)";
      toJsonExpr = "$fieldName${isNullable ? '?' : ''}.toJson()";
    }

    return _Field(
      jsonKey: propName,
      fieldName: fieldName,
      dartType: dartType,
      fromJsonExpr: fromJsonExpr,
      toJsonExpr: toJsonExpr,
      isNullable: isNullable,
      description: schema["description"] as String?,
    );
  }
}

class _Operation {
  final String path;
  final String method;
  final Map<String, dynamic> data;

  _Operation({required this.path, required this.method, required this.data});
}

class _Param {
  final String rawName;
  final String dartName;
  final String dartType;
  final bool isRequired;

  _Param(this.rawName, this.dartName, this.dartType, this.isRequired);
}
