import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:vector_graphics_compiler/vector_graphics_compiler.dart';

final packageRoot = p.dirname(p.dirname(Platform.script.toFilePath()));
final sourceIconsPath = p.join(packageRoot, 'assets', 'svgs');

void main() async {
  print('OMSA Icons Generator');
  print('Package root: $packageRoot');
  print('Source SVGs: $sourceIconsPath');
  print('');

  final outputAssetsPath = p.join(packageRoot, 'assets', 'icons');
  final outputLibPath = p.join(packageRoot, 'lib', 'src');

  print('Output assets: $outputAssetsPath');
  print('Output lib: $outputLibPath');
  print('');

  await _prepareDirectories(outputAssetsPath, outputLibPath);

  final svgFiles = await _findSvgFiles();
  print('Found ${svgFiles.length} SVG files');
  print('');

  final icons = <IconInfo>[];
  final iconNames = <String>{};
  var processed = 0;

  for (final svgFile in svgFiles) {
    try {
      final iconInfo = await _processSvgFile(svgFile, outputAssetsPath);

      if (iconNames.contains(iconInfo.dartName)) {
        print(
          'Warning: Duplicate icon name ${iconInfo.dartName}, using ${iconInfo.dartName}_${iconInfo.category.toLowerCase()}',
        );
        iconInfo.dartName =
            '${iconInfo.dartName}_${iconInfo.category.toLowerCase()}';
      }

      icons.add(iconInfo);
      iconNames.add(iconInfo.dartName);
      processed++;

      if (processed % 50 == 0) {
        print('Processed $processed/${svgFiles.length}...');
      }
    } catch (e) {
      print('Failed to process ${p.basename(svgFile.path)}: $e');
    }
  }

  print('Processed $processed/${svgFiles.length} icons');
  print('');

  await _generateMainLibrary(icons, packageRoot);
  await _generateIconDataClass(outputLibPath);

  print('Icon generation complete');
  print('Generated ${icons.length} icons');
  print('');

  print('Running dart format...');
  await _runDartFormat(packageRoot);

  print('');
  print('Usage:');
  print('  import \'package:omsa_icons/omsa_icons.dart\';');
  print('  OmsaIcons.search(size: 24)');
}

Future<void> _prepareDirectories(String assetsPath, String libPath) async {
  print('Preparing directories...');

  final assetsDir = Directory(assetsPath);
  if (await assetsDir.exists()) {
    await assetsDir.delete(recursive: true);
  }
  await assetsDir.create(recursive: true);

  final libDir = Directory(libPath);
  if (await libDir.exists()) {
    await libDir.delete(recursive: true);
  }
  await libDir.create(recursive: true);
}

Future<List<File>> _findSvgFiles() async {
  final sourceDir = Directory(sourceIconsPath);
  if (!await sourceDir.exists()) {
    throw Exception('Source icons directory not found: $sourceIconsPath');
  }

  final svgFiles = <File>[];
  await for (final entity in sourceDir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.svg')) {
      svgFiles.add(entity);
    }
  }

  return svgFiles;
}

Future<IconInfo> _processSvgFile(File svgFile, String outputAssetsPath) async {
  final relativePath = p.relative(svgFile.path, from: sourceIconsPath);
  final parts = p.split(relativePath);

  if (parts.length < 2) {
    throw Exception('Invalid SVG path structure: $relativePath');
  }

  final category = parts[0];
  final fileName = p.basenameWithoutExtension(parts.last);

  final dartName = _toPascalCase(fileName);
  final assetName = _toSnakeCase(fileName);

  final svgContent = await svgFile.readAsString();

  final vecOutputPath = p.join(outputAssetsPath, '$assetName.vec');
  await _compileSvgToVec(svgContent, vecOutputPath);

  return IconInfo(
    category: category,
    name: fileName,
    dartName: dartName,
    assetName: assetName,
    assetPath: 'assets/icons/$assetName.vec',
  );
}

Future<void> _compileSvgToVec(String svgContent, String outputPath) async {
  final compiled = encodeSvg(
    xml: svgContent,
    debugName: p.basename(outputPath),
    enableClippingOptimizer: false,
    enableMaskingOptimizer: false,
    enableOverdrawOptimizer: false,
  );

  final outputFile = File(outputPath);
  await outputFile.writeAsBytes(compiled.buffer.asUint8List());
}

String _toPascalCase(String name) {
  final normalized = _normalizeNorwegianCharacters(name);

  if (!normalized.contains(' ') &&
      !normalized.contains('_') &&
      !normalized.contains('-')) {
    return normalized;
  }

  return normalized
      .replaceAll(RegExp(r'[^a-zA-Z0-9]'), ' ')
      .split(' ')
      .where((word) => word.isNotEmpty)
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join('');
}

String _normalizeNorwegianCharacters(String name) {
  return name
      .replaceAll('ø', 'o')
      .replaceAll('Ø', 'O')
      .replaceAll('æ', 'ae')
      .replaceAll('Æ', 'Ae')
      .replaceAll('å', 'a')
      .replaceAll('Å', 'A');
}

String _toSnakeCase(String name) {
  final pascalCase = _toPascalCase(name);
  return pascalCase
      .replaceAllMapped(
        RegExp(r'[A-Z]'),
        (match) => '_${match.group(0)!.toLowerCase()}',
      )
      .substring(1);
}

Future<void> _generateMainLibrary(
  List<IconInfo> icons,
  String packageRoot,
) async {
  print('Generating main library...');

  icons.sort((a, b) => a.dartName.compareTo(b.dartName));

  final buffer = StringBuffer();
  buffer.writeln(
    '// ignore_for_file: constant_identifier_names, non_constant_identifier_names',
  );
  buffer.writeln();
  buffer.writeln('library;');
  buffer.writeln();
  buffer.writeln('import \'src/omsa_icons_data.dart\';');
  buffer.writeln();
  buffer.writeln('export \'src/omsa_icons_data.dart\';');
  buffer.writeln();

  buffer.writeln('class OmsaIcons {');
  buffer.writeln('  OmsaIcons._();');
  buffer.writeln();

  for (final icon in icons) {
    buffer.writeln(
      '  static const ${icon.dartName} = OmsaIconData(\'${icon.assetPath}\');',
    );
  }

  buffer.writeln('}');

  final file = File(p.join(packageRoot, 'lib', 'omsa_icons.dart'));
  await file.writeAsString(buffer.toString());
}

Future<void> _generateIconDataClass(String outputLibPath) async {
  print('Generating icon data class...');

  final buffer = StringBuffer();
  buffer.writeln('import \'package:flutter/widgets.dart\';');
  buffer.writeln('import \'package:vector_graphics/vector_graphics.dart\';');
  buffer.writeln();
  buffer.writeln('class OmsaIconData {');
  buffer.writeln('  const OmsaIconData(this.assetPath);');
  buffer.writeln();
  buffer.writeln('  final String assetPath;');
  buffer.writeln();
  buffer.writeln('  Widget call({');
  buffer.writeln('    Key? key,');
  buffer.writeln('    double? size,');
  buffer.writeln('    double? width,');
  buffer.writeln('    double? height,');
  buffer.writeln('    Color? color,');
  buffer.writeln('    BoxFit fit = BoxFit.contain,');
  buffer.writeln('    Alignment alignment = Alignment.center,');
  buffer.writeln('    String? semanticsLabel,');
  buffer.writeln('    bool excludeFromSemantics = false,');
  buffer.writeln('    Clip clipBehavior = Clip.hardEdge,');
  buffer.writeln('  }) {');
  buffer.writeln('    final effectiveWidth = size ?? width;');
  buffer.writeln('    final effectiveHeight = size ?? height;');
  buffer.writeln('    final colorFilter = color != null');
  buffer.writeln('        ? ColorFilter.mode(color, BlendMode.srcIn)');
  buffer.writeln('        : null;');
  buffer.writeln();
  buffer.writeln('    return VectorGraphic(');
  buffer.writeln('      key: key,');
  buffer.writeln(
    '      loader: AssetBytesLoader(assetPath, packageName: \'omsa_icons\'),',
  );
  buffer.writeln('      width: effectiveWidth,');
  buffer.writeln('      height: effectiveHeight,');
  buffer.writeln('      fit: fit,');
  buffer.writeln('      alignment: alignment,');
  buffer.writeln('      semanticsLabel: semanticsLabel,');
  buffer.writeln('      excludeFromSemantics: excludeFromSemantics,');
  buffer.writeln('      clipBehavior: clipBehavior,');
  buffer.writeln('      colorFilter: colorFilter,');
  buffer.writeln('    );');
  buffer.writeln('  }');
  buffer.writeln('}');

  final file = File(p.join(outputLibPath, 'omsa_icons_data.dart'));
  await file.writeAsString(buffer.toString());
}

Future<void> _runDartFormat(String packageRoot) async {
  final result = await Process.run('dart', [
    'format',
    '.',
  ], workingDirectory: packageRoot);

  if (result.exitCode == 0) {
    print('Successfully formatted generated files');
  } else {
    print('Warning: dart format failed with exit code ${result.exitCode}');
    if (result.stderr.toString().isNotEmpty) {
      print(result.stderr);
    }
  }
}

class IconInfo {
  final String category;
  final String name;
  String dartName;
  final String assetName;
  final String assetPath;

  IconInfo({
    required this.category,
    required this.name,
    required this.dartName,
    required this.assetName,
    required this.assetPath,
  });
}
