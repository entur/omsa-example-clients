#!/usr/bin/env dart
// Token generator for OMSA Design System
// Generates Flutter color tokens from Figma JSON exports

// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  final String tokenSourcePath = args.isNotEmpty ? args[0] : throw ArgumentError(
    'Please provide the path to a copy of the Linje token directory as an argument.',
  );

  print('🎨 Generating OMSA Design System tokens from: $tokenSourcePath');

  final generator = TokenGenerator(tokenSourcePath);
  generator.generateAll();

  print('✅ Token generation complete!');
}

class TokenGenerator {
  final String sourcePath;
  final String outputPath;

  TokenGenerator(
    this.sourcePath, [
    String? outputPath,
  ]) : outputPath = outputPath ??
            '${Directory.current.path}/lib/theme/tokens';

  void generateAll() {
    // Ensure output directory exists
    Directory(outputPath).createSync(recursive: true);

    print('📦 Generating primitive tokens...');
    _generatePrimitiveTokens();

    print('📦 Generating data visualization tokens...');
    _generateDataTokens();

    print('📦 Generating transport mode tokens...');
    _generateTransportTokens();

    print('📦 Generating semantic tokens...');
    _generateSemanticTokens();

    print('📦 Generating base element tokens...');
    _generateBaseTokens();

    print('📦 Generating component tokens...');
    _generateComponentTokens();

    print('📦 Generating token barrel file...');
    _generateBarrelFile();
  }

  void _generatePrimitiveTokens() {
    final json = _readTokenFile('primitive.json');
    final tokens = _parseTokens(json);

    final buffer = StringBuffer();
    buffer.writeln("// Generated from Enturs Linje tokens - do not modify!");
    buffer.writeln("// ignore_for_file: constant_identifier_names");
    buffer.writeln();
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln();
    buffer.writeln("/// Primitive color tokens from design system");
    buffer.writeln("/// These are the base colors that all other tokens reference");
    buffer.writeln("abstract class PrimitiveColorTokens {");

    // Group tokens by color family
    final grouped = <String, List<ColorToken>>{};
    for (final token in tokens) {
      final family = token.name.split('/').first;
      grouped.putIfAbsent(family, () => []).add(token);
    }

    for (final entry in grouped.entries) {
      buffer.writeln();
      buffer.writeln("  // ${entry.key} family");

      for (final token in entry.value) {
        final varName = _toVariableName(token.name);
        buffer.writeln(
            "  static const Color $varName = Color(${_hexToColorInt(token.value)});");
      }
    }

    buffer.writeln("}");

    _writeFile('primitive_color_tokens.dart', buffer.toString());
  }

  void _generateDataTokens() {
    final json = _readTokenFile('data.json');
    final tokens = _parseTokens(json);

    final buffer = StringBuffer();
    buffer.writeln("// Generated from Enturs Linje tokens - do not modify!");
    buffer.writeln("// ignore_for_file: constant_identifier_names");
    buffer.writeln();
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln();
    buffer.writeln("/// Data visualization color tokens from design system");
    buffer.writeln("/// These are specialized colors for charts, graphs, and data viz");
    buffer.writeln("abstract class DataColorTokens {");

    for (final token in tokens) {
      final varName = _toVariableName(token.name);
      buffer.writeln(
          "  static const Color $varName = Color(${_hexToColorInt(token.value)});");
    }

    buffer.writeln("}");

    _writeFile('data_color_tokens.dart', buffer.toString());
  }

  void _generateTransportTokens() {
    final json = _readTokenFile('transport.json');
    final tokens = _parseTokens(json);

    final buffer = StringBuffer();
    buffer.writeln("// Generated from Enturs Linje tokens - do not modify!");
    buffer.writeln("// ignore_for_file: constant_identifier_names");
    buffer.writeln();
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln();
    buffer.writeln("/// Transport mode color tokens from design system");
    buffer.writeln("/// These are specialized colors for different transport modes");
    buffer.writeln("abstract class TransportColorTokens {");

    // Group by transport mode
    final grouped = <String, List<ColorToken>>{};
    for (final token in tokens) {
      final mode = token.name.split('/').first;
      grouped.putIfAbsent(mode, () => []).add(token);
    }

    for (final entry in grouped.entries) {
      buffer.writeln();
      buffer.writeln("  // ${entry.key}");

      for (final token in entry.value) {
        final varName = _toVariableName(token.name);
        buffer.writeln(
            "  static const Color $varName = Color(${_hexToColorInt(token.value)});");
      }
    }

    buffer.writeln("}");

    _writeFile('transport_color_tokens.dart', buffer.toString());
  }

  void _generateSemanticTokens() {
    final json = _readTokenFile('semantic.json');
    final tokens = _parseTokens(json);

    final buffer = StringBuffer();
    buffer.writeln("// Generated code - do not modify by hand");
    buffer.writeln("// Generated from Enturs Linje tokens - do not modify!");

    buffer.writeln("// ignore_for_file: constant_identifier_names");
    buffer.writeln();
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln("import 'primitive_color_tokens.dart';");
    buffer.writeln();
    buffer.writeln("/// Semantic color tokens from design system");
    buffer.writeln(
        "/// These tokens reference primitive colors and provide semantic meaning");
    buffer.writeln("abstract class SemanticColorTokens {");

    // Group by top-level category
    final grouped = <String, List<ColorToken>>{};
    for (final token in tokens) {
      final category = token.name.split('/').first;
      grouped.putIfAbsent(category, () => []).add(token);
    }

    for (final entry in grouped.entries) {
      buffer.writeln();
      buffer.writeln("  // ${entry.key}");

      for (final token in entry.value) {
        final varName = _toVariableName(token.name);
        // Use 'var' field if present (references the immediate parent layer)
        // Otherwise use rootAlias (references primitives directly)
        // Fall back to hardcoded value if neither exists
        String reference;
        if (token.varReference.isNotEmpty) {
              reference = 'PrimitiveColorTokens.${_toVariableName(token.varReference)}';
        } else if (token.rootAlias.isNotEmpty) {
          reference = 'PrimitiveColorTokens.${_toVariableName(token.rootAlias)}';
        } else {
          reference = 'Color(${_hexToColorInt(token.value)})';
        }
        buffer.writeln("  static const Color $varName = $reference;");
      }
    }

    buffer.writeln("}");

    _writeFile('semantic_color_tokens.dart', buffer.toString());
  }

  void _generateBaseTokens() {
    final json = _readTokenFile('base.json');

    // Base tokens can have multiple modes (Light/Dark)
    final collection = jsonDecode(json)[0] as Map<String, dynamic>;
    final values = collection['values'] as List<dynamic>;

    final buffer = StringBuffer();
    buffer.writeln("// Generated from Enturs Linje tokens - do not modify!");
    buffer.writeln("// ignore_for_file: constant_identifier_names");
    buffer.writeln();
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln("import 'semantic_color_tokens.dart';");
    buffer.writeln("import 'transport_color_tokens.dart';");
    buffer.writeln();
    buffer.writeln("/// Base element color tokens from design system");
    buffer.writeln(
        "/// These tokens reference semantic and transport colors for common UI elements");

    for (final modeData in values) {
      final mode = modeData['mode'] as Map<String, dynamic>;
      final modeName = mode['name'] as String;
      final tokens = _parseColorList(modeData['color'] as List<dynamic>);

      buffer.writeln();
      buffer.writeln("/// Base tokens for $modeName mode");
      buffer.writeln("abstract class Base${modeName}Tokens {");

      // Group by category
      final grouped = <String, List<ColorToken>>{};
      for (final token in tokens) {
        // Remove "Base colors/" prefix
        final cleanName =
            token.name.replaceFirst('Base colors/', '');
        final category = cleanName.split('/').first;
        grouped.putIfAbsent(category, () => []).add(token.copyWith(name: cleanName));
      }

      for (final entry in grouped.entries) {
        buffer.writeln();
        buffer.writeln("  // ${entry.key}");

        for (final token in entry.value) {
          final varName = _toVariableName(token.name);
          // Use 'var' field to reference semantic or transport tokens
          // Check if it references transport tokens
          String reference;
          if (token.varReference.isNotEmpty) {
            final transportModes = ['Bicycle', 'Bus', 'Ferry', 'Funicular', 'Helicopter',
                                   'Metro', 'Mobility', 'Plane', 'Taxi', 'Train', 'Tram',
                                   'Walk', 'Cableway', 'AirportLinkBus', 'AirportLinkRail',
                                   'Carferry', 'Citybike'];
            final isTransport = transportModes.any((mode) => token.varReference.toLowerCase().contains(mode.toLowerCase()));
            if (isTransport) {
              reference = 'TransportColorTokens.${_toVariableName(token.varReference)}';
            } else {
              reference = 'SemanticColorTokens.${_toVariableName(token.varReference)}';
            }
          } else {
            reference = 'Color(${_hexToColorInt(token.value)})';
          }
          buffer.writeln("  static const Color $varName = $reference;");
        }
      }

      buffer.writeln("}");
    }

    _writeFile('base_color_tokens.dart', buffer.toString());
  }

  void _generateComponentTokens() {
    final json = _readTokenFile('component.json');

    // Component tokens can have multiple modes (Light/Dark)
    final collection = jsonDecode(json)[0] as Map<String, dynamic>;
    final values = collection['values'] as List<dynamic>;

    final buffer = StringBuffer();
    buffer.writeln("// Generated from Enturs Linje tokens - do not modify!");
    buffer.writeln("// ignore_for_file: constant_identifier_names");
    buffer.writeln();
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln("import 'base_color_tokens.dart';");
    buffer.writeln("import 'semantic_color_tokens.dart';");
    buffer.writeln("import 'transport_color_tokens.dart';");
    buffer.writeln();
    buffer.writeln("/// Component-specific color tokens from design system");
    buffer.writeln("/// These tokens reference base, semantic, and transport colors for specific components");

    for (final modeData in values) {
      final mode = modeData['mode'] as Map<String, dynamic>;
      final modeName = mode['name'] as String;
      final tokens = _parseColorList(modeData['color'] as List<dynamic>);

      buffer.writeln();
      buffer.writeln("/// Component tokens for $modeName mode");
      buffer.writeln("abstract class Component${modeName}Tokens {");

      // Group by component type
      final grouped = <String, List<ColorToken>>{};
      for (final token in tokens) {
        // Remove "Components/" prefix and get component type
        final cleanName = token.name.replaceFirst('Components/', '');
        final parts = cleanName.split('/');
        final componentType = parts.length > 1 ? '${parts[0]}/${parts[1]}' : parts[0];
        grouped.putIfAbsent(componentType, () => []).add(token.copyWith(name: cleanName));
      }

      for (final entry in grouped.entries) {
        buffer.writeln();
        buffer.writeln("  // ${entry.key}");

        for (final token in entry.value) {
          final varName = _toVariableName(token.name);

          // Determine the reference - Use 'var' field to reference parent layer
          // Components can reference semantic, base, or transport tokens
          String reference;
          if (token.varReference.isNotEmpty) {
            // Check if it's a base token reference (starts with "Base colors/")
            if (token.varReference.startsWith('Base colors/')) {
              final baseTokenName = token.varReference.replaceFirst('Base colors/', '');
              reference = 'Base${modeName}Tokens.${_toVariableName(baseTokenName)}';
            } else {
              // Check if it's a transport token
              final transportModes = ['Bicycle', 'Bus', 'Ferry', 'Funicular', 'Helicopter',
                                     'Metro', 'Mobility', 'Plane', 'Taxi', 'Train', 'Tram',
                                     'Walk', 'Cableway', 'AirportLinkBus', 'AirportLinkRail',
                                     'Carferry', 'Citybike'];
              final isTransport = transportModes.any((mode) => token.varReference.toLowerCase().contains(mode.toLowerCase()));
              if (isTransport) {
                reference = 'TransportColorTokens.${_toVariableName(token.varReference)}';
              } else {
                // It's a semantic token reference
                reference = 'SemanticColorTokens.${_toVariableName(token.varReference)}';
              }
            }
          } else {
            // No reference, use hardcoded value
            reference = 'Color(${_hexToColorInt(token.value)})';
          }

          buffer.writeln("  static const Color $varName = $reference;");
        }
      }

      buffer.writeln("}");
    }

    _writeFile('component_color_tokens.dart', buffer.toString());
  }

  void _generateBarrelFile() {
    final buffer = StringBuffer();
    buffer.writeln("// Generated code - do not modify by hand");
    buffer.writeln();
    buffer.writeln("export 'primitive_color_tokens.dart';");
    buffer.writeln("export 'data_color_tokens.dart';");
    buffer.writeln("export 'transport_color_tokens.dart';");
    buffer.writeln("export 'semantic_color_tokens.dart';");
    buffer.writeln("export 'base_color_tokens.dart';");
    buffer.writeln("export 'component_color_tokens.dart';");

    _writeFile('tokens.dart', buffer.toString());
  }

  List<ColorToken> _parseTokens(String json) {
    final data = jsonDecode(json);
    final collection = data[0] as Map<String, dynamic>;
    final values = collection['values'] as List<dynamic>;
    final modeData = values[0] as Map<String, dynamic>;
    final colors = modeData['color'] as List<dynamic>;

    return _parseColorList(colors);
  }

  List<ColorToken> _parseColorList(List<dynamic> colors) {
    return colors.map((c) {
      final color = c as Map<String, dynamic>;
      return ColorToken(
        name: color['name'] as String,
        value: color['value'] as String,
        varRef: color['var'] as String? ?? '',
        rootAlias: color['rootAlias'] as String? ?? '',
      );
    }).toList();
  }

  String _readTokenFile(String filename) {
    final file = File('$sourcePath/$filename');
    if (!file.existsSync()) {
      throw Exception('Token file not found: ${file.path}');
    }
    return file.readAsStringSync();
  }

  void _writeFile(String filename, String content) {
    final file = File('$outputPath/$filename');
    file.writeAsStringSync(content);
    print('   ✓ Generated $filename');
  }

  String _toVariableName(String tokenName) {
    // Convert "Blue/10" to "blue10"
    // Convert "Fill/Background/Contrast/Dark" to "fillBackgroundContrastDark"
    final parts = tokenName.split('/');
    final result = StringBuffer();

    for (var i = 0; i < parts.length; i++) {
      final part = parts[i]
          .replaceAll('-', '_')
          .replaceAll(' ', '_');

      if (i == 0) {
        result.write(part[0].toLowerCase() + part.substring(1));
      } else {
        result.write(part[0].toUpperCase() + part.substring(1));
      }
    }

    return result.toString().replaceAll('_', '');
  }

  String _hexToColorInt(String hex) {
    // Convert "#RRGGBB" or "#RRGGBBAA" to "0xAARRGGBB"
    final String cleanHex = hex.replaceFirst('#', '');

    if (cleanHex.length == 6) {
      return '0xFF$cleanHex';
    } else if (cleanHex.length == 8) {
      // RRGGBBAA -> AARRGGBB
      final alpha = cleanHex.substring(6, 8);
      final rgb = cleanHex.substring(0, 6);
      return '0x$alpha$rgb';
    }

    throw Exception('Invalid hex color: $hex');
  }
}

class ColorToken {
  final String name;
  final String value;
  final String varRef;
  final String rootAlias;

  ColorToken({
    required this.name,
    required this.value,
    required this.varRef,
    required this.rootAlias,
  });

  String get varReference => varRef;

  ColorToken copyWith({
    String? name,
    String? value,
    String? varRef,
    String? rootAlias,
  }) {
    return ColorToken(
      name: name ?? this.name,
      value: value ?? this.value,
      varRef: varRef ?? this.varRef,
      rootAlias: rootAlias ?? this.rootAlias,
    );
  }
}
